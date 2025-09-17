import { createFromRoot } from 'codama';
import { rootNodeFromAnchor } from '@codama/nodes-from-anchor';
import { renderVisitor } from 'codama-dart'; 
import path from 'path';
import fs from 'fs';
    
// Load the IDL files explicitly
const anchorProgramIdl = JSON.parse(fs.readFileSync('target/idl/anchor_program.json', 'utf8'));
const anchorDataStructuresIdl = JSON.parse(fs.readFileSync('target/idl/data_structures.json', 'utf8'));

// Output base path for generated clients inside my dart-project
const BASE_CLIENTS_PATH = '../dart-project/clients';

// Define the IDLs and their corresponding program names
const idls = [
    { idl: anchorProgramIdl, name: 'anchor_program' },
    { idl: anchorDataStructuresIdl, name: 'anchor_data_structures' },
];

// Generate clients for each IDL in each language
for (const { idl, name: programName } of idls) {
    const codama = createFromRoot(rootNodeFromAnchor(idl as any));
    const outDir = path.join(BASE_CLIENTS_PATH, 'dart', 'generated', programName);
    console.log('Outputting to', outDir);
    codama.accept(renderVisitor(outDir));
}