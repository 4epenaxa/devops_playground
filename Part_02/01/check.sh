# check.sh

check_absolute_path() {
    local absolutePath="$1"
    if [[ ! "$absolutePath" =~ ^/ ]]; then
        echo "Error:    The provided path '$absolutePath' is not an absolute path."
        exit 1
    fi
    if [ ! -d "$absolutePath" ]; then
        echo "Error:    The provided path '$absolutePath' is not a valid directory."
        exit 1
    fi
}

check_number_parameter() {
    local parameter_name="$1"
    local parameter_value="$2"
    if ! [[ "$parameter_value" =~ ^[0-9]+$ ]]; then
        echo "Error:    The $parameter_name '$parameter_value' is not a valid number."
        exit 1
    fi
    if [ "$parameter_value" -le 0 ]; then
        echo "Error:    The $parameter_name '$parameter_value' must be greater then 0."
        exit 1
    fi
}
check_subfolders_name() {
    local subfoldersName="$1"
    if ! [[ "$subfoldersName" =~ ^[a-zA-Z]{1,7}$ ]]; then
        echo "Error:    The third argument '$subfoldersName' is not valid."
        echo "          It should consist of English alphabet letters (up to 7 characters)."
        exit 1
    fi
}

check_files_name() {
    local filesName="$1"
    if ! [[ "$filesName" =~ ^[a-zA-Z]{1,7}\.[a-zA-Z]{1,3}$ ]]; then
        echo "Error:    The fifth argument '$filesName' is not valid."
        echo "          It should be in the format 'name.ext'"
        echo "          with up to 7 characters for the name and up to 3 characters for the extension,"
        echo "          containing only English alphabet letters, and one dot between."
        exit 1
    fi
}

check_files_size() {
    local filesSize="$1"
    if ! [[ "$filesSize" =~ ^[1-9][0-9]?kb$|100kb$ ]]; then
        echo "Error:    The sixth argument '$filesSize' is not valid. It should be in the format 'numberkb'"
        echo "          (e.g., '1kb', '50kb', '100kb') with a number greater than 0 and less than or equal to 100."
        exit 1
    fi
}
