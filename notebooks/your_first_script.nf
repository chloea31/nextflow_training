#!/usr/bin/env nextflow // shebang: indicates what program should be used to interpret this script code

// Default parameter input
params.str = "Hello world!"

// split process
process split {
    publishDir "results/lower"
    
    input:
    val x
    
    output:
    path 'chunk_*' 
    // "I do not care about what new things appear in this folder, but I only care about these ones to be passed to the next process"

    script:
    """
    printf '${x}' | split -b 6 - chunk_
    """
} 
// the string was split in files, each of them containing no more than 6 characters of the original string
// we also want each of these files to be named chunk_

// convert_to_upper process
process convert_to_upper {
    publishDir "results/upper"
    tag "$y"

    input:
    path y

    output:
    path 'upper_*'

    script:
    """
    cat $y | tr '[a-z]' '[A-Z]' > upper_${y}
    """
}
// this process converts strings to upper

// Workflow block
workflow {
    ch_str = channel.of(params.str)       // Create a channel using parameter input
    ch_chunks = split(ch_str)             // Split string into chunks and create a named channel
    convert_to_upper(ch_chunks.flatten()) // Convert lowercase letters to uppercase letters
}