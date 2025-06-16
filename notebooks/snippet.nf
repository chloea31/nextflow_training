#!/usr/bin/env nextflow

nextflow.enable.dsl=2

process SAYHELLO {
    script:
    """
    echo 'Hello world!'
    """
}

process EXAMPLE {

    output:
        path "chunk_archive.gz"
    script:
    """
    echo 'Hello world!\nHola mundo!\nCiao mondo!\nHallo Welt!' > file
    cat file | head -n 1 | head -c 5 > chunk_1.txt
    gzip -c chunk_1.txt  > chunk_archive.gz
    """
}

//workflow {
    //EXAMPLE()
    //| view()
//}

process PYSTUFF {
    debug true

    script:
    """
    #!/usr/bin/env python

    x = 'Hello'
    y = 'world!'
    print ("%s - %s" % (x, y))
    """
}

params.data = 'World'

process FOO {
    debug true

    script:
    """
    echo Hello $params.data
    """
}

process FOO_2 {
    debug true

    script:
    """
    echo "The current directory is \$PWD"
    """
}

process BAR {
    debug true

    script:
    '''
    echo "The current directory is $PWD"
    '''
}

params.data2 = 'le monde'

process BAZ {
    shell:
    '''
    X='Bonjour'
    echo $X !{params.data2}
    '''
}

params.compress = 'gzip'
params.file2compress = "$projectDir/data/ggal/transcriptome.fa"

process FOO {
    debug true

    input:
    path file

    script:
    if (params.compress == 'gzip')
        """
        echo "gzip -c $file > ${file}.gz"
        """
    else if (params.compress == 'bzip2')
        """
        echo "bzip2 -c $file > ${file}.bz2"
        """
    else
        throw new IllegalArgumentException("Unknown compressor $params.compress")
}

workflow {
    FOO(params.file2compress)
}