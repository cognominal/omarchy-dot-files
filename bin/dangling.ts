import * as fs from 'fs';
import * as path from 'path';
import { execSync } from 'child_process';
import { homedir } from 'os';

const gitDir: string = path.join(homedir(), 'git');
const vimDir: string = path.join(homedir(), 'vim');

// Ensure ~/vim directory exists
if (!fs.existsSync(vimDir)) {
    fs.mkdirSync(vimDir, { recursive: true });
}

// Function to check if a path is a dangling symlink
function isDanglingSymlink(filePath: string): boolean {
    try {
        fs.readlinkSync(filePath);
        return !fs.existsSync(filePath);
    } catch (error) {
        return false;
    }
}

// Find all dangling symlinks in gitDir
const files: string[] = fs.readdirSync(gitDir);
const danglingSymlinks: string[] = files
    .map(file => path.join(gitDir, file))
    .filter(file => isDanglingSymlink(file));

if (danglingSymlinks.length === 0) {
    console.log(`No dangling symlinks found in ${gitDir}`);
    process.exit(0);
}

// Process each dangling symlink
danglingSymlinks.forEach(symlink => {
    const symlinkName: string = path.basename(symlink);
    const match: RegExpMatchArray | null = symlinkName.match(/^([a-zA-Z0-9_-]+)---([a-zA-Z0-9_-]+)$/);

    if (match) {
        const user: string = match[1];
        const repo: string = match[2];
        const githubUrl: string = `https://github.com/${user}/${repo}`;
        const targetDir: string = path.join(vimDir, repo);

        console.log(`Cloning ${githubUrl} into ${targetDir}`);

        try {
            execSync(`git clone --depth 1 ${githubUrl} ${targetDir}`, { stdio: 'inherit' });
            console.log(`Successfully cloned ${repo}`);
        } catch (error) {
            console.error(`Failed to clone ${repo}: ${error.message}`);
        }
    } else {
        console.log(`Skipping ${symlinkName}: does not match user---repo pattern`);
    }
});
