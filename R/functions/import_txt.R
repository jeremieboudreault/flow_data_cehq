# import_txt.R


# Get flow data from cehq.qc.ca -- implemented for linux only



import_txt <- function(
    station_numbers, # stations to be imported
    suffix = "Q", # Looking for _Q.txt files (or _N.txt files?), can be a vector
    replace = T, # replace existing files (or skip download)
    wait = 1,
    verbose = T
) {

    # filenames (as on the cehq website)
    filenames <- paste0(station_numbers,"_",suffix,".txt")

    # check if some already exist
    existing_files <- intersect(list.files("data"),filenames)

    if(replace & length(existing_files) > 0) file.remove(file.path("data", existing_files))
    if(!replace & length(existing_files) > 0){
        filenames <- setdiff(filenames, existing_files)
        if(length(filenames) == 0 & verbose){
            cat("All stations selected have an associated `.txt` file in the data/ folder.\n",
                "Because replace = F, nothing is done and the procedure is aborted.\n")
            return(NULL)
        }
    }

    # Detect OS and begin importation.
    OS <- Sys.info()['sysname']

    if(OS == "Linux"){

        # construct appropriate urls
        urls <- paste0("https://www.cehq.gouv.qc.ca/depot/historique_donnees/fichier/",filenames)

        # write file with urls in it
        write.table(data.frame(urls), "data/temp_station_urls00.txt", row.names = F, col.names = F, quote = F)

        # run command in terminal
        shell_command <- paste0("cd data/; wget --input-file temp_station_urls00.txt --wait=",wait)
        system(command = shell_command)

        # remove temp file
        file.remove("data/temp_station_urls00.txt")

    }else{
        cat("Implemented only for Linux OS (so far).\n")
    }

    # Do for Windows and Mac machines as well
    # Mac : curl -O <url>? curl http://example.com/textfile.txt -o textfile.txt


    return(NULL)
}

