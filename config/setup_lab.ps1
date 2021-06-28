# Script to configure the WWT PF lab for DEVASC Data Formats hands-on exercises

# Constants
$FRAME = "-" * 49
$S3_BUCKET_URI = "https://devasc-data-formats.s3-us-west-2.amazonaws.com/"
$CHROME_ARGS = "--allow-insecure-localhost"
$DOCKER_REGISTRY_PATH = "lab-docker.wwtatc.com/devnet/"
$DOCKER_SETTINGS_FILE = "settings.json"
$DOCKER_SETTINGS_URI = $S3_BUCKET_URI + $DOCKER_SETTINGS_FILE
$DOCKER_SETTINGS_FILE_PATH = "c:\Users\admin\AppData\Roaming\Docker\"
$REPO_FILE = ".repo"
$REPO_FILE_URI = $S3_BUCKET_URI + $REPO_FILE
$REPO_NAME = "devasc-data-formats"
$JUPYTER_S3_BUCKET_URI = "https://jupyter-launcher-v2.s3-us-west-2.amazonaws.com/"
$JUPYTER_SCRIPT = "jupyter_launcher_v2.ps1"
$JUPYTER_SCRIPT_URI = $JUPYTER_S3_BUCKET_URI + $JUPYTER_SCRIPT
$ROOT_PATH = "C:\Users\admin"

# Force PowerShell to catch all errors in try/catch blocks
$ErrorActionPreference = "Stop"

# Handle errors
function handle_error($error_message=$False) {
    Write-Host ""
    if($error_message){
        Write-Warning $error_message
    }
    else {
        Write-Warning "An unknown error occurred - please try again."
    }
    Start-Sleep -Seconds 5
    Write-Host ""
    exit
}


# Display script intro
function display_intro() {
    Write-Host ""
    write-Host $FRAME
    Write-Host "** Setting up the Data Formats Lab **" -ForegroundColor Green
    Write-Host "** This will take 5-10 minutes, please wait **" -ForegroundColor Green
    write-Host $FRAME
    Write-Host ""

    Start-Sleep -Seconds 1
}


# Verify the Docker service and Windows process are running
function docker_status() {
    try {
        Write-Host "Checking Docker service & process statuses..." -NoNewline -ForegroundColor Green
        $docker_service_status = Get-Service -DisplayName "Docker*" | Where-Object {$_.Status -eq "Running"}
        $docker_process_status = docker info | Select-String -Pattern 'ERROR' | ForEach-Object {$_.Matches.Success}
        Write-Host "done." -ForegroundColor Green
        Write-Host ""

        if (-not ($docker_service_status)) {
            handle_error("Docker Desktop Windows service not running. `nPlease wait for the service to start and try again.")
        }

        if ($docker_process_status) {
            # If Docker Deskop process is hung, attempt to kill
            # $docker_process = Get-Process "Docker Desktop"
            # if ($docker_process.Count -gt 0) {
            #     $docker_process[0].Kill()
            #     $docker_process[0].WaitForExit()
            # }

            # If Docker Desktop process does not respond, attempt to start
            Start-Process "C:\Program Files\Docker\Docker\Docker Desktop.exe"
            Write-Host "Docker Desktop process not running, attempting restart..." -NoNewline -ForegroundColor Yellow
            Start-Sleep 15
            Write-Host "done." -ForegroundColor Yellow
            Write-Host

            handle_error("Docker Desktop process was not running, restart automatically attempted. `nPlease try again.  If the problem persists, launch a new copy of the lab.")
        }
    }
    catch {
        handle_error("Unable to determine the Docker service and process statuses, please try again.")
    }
}


# Windows preparation
function setup_windows() {
    # Disable Windows Updates & delete temporary update files
    try {
        if (-not (Test-Path .winupdate -PathType leaf)) {
            Write-Host "Disabling Windows Update..." -NoNewline -ForegroundColor Green
            Start-Process PowerShell -WindowStyle Minimized -Verb Runas -ArgumentList "Stop-Service wuauserv; Set-Service -Name wuauserv -StartupType Disabled; Get-ChildItem -Path C:\WINDOWS\SoftwareDistribution\Download -Verbose | Remove-Item -Force -Confirm:`$false -Recurse -ErrorAction SilentlyContinue"
            Out-File -FilePath .winupdate
            Write-Host "done." -ForegroundColor Green
            Write-Host ""
        }
    }
    catch {
        handle_error("An error occurred disabling Windows Update, please try again.")
    }
}


# Docker Desktop preparation
function setup_docker() {
    try {
        if (!(Test-Path .dockerclean -PathType leaf)) {
            # Configure Docker settings (disable updates, add C:\ mount permissions, etc.)
            Write-Host "Configuring Docker settings..." -NoNewline -ForegroundColor Green
            $settings_file = $DOCKER_SETTINGS_FILE_PATH + $DOCKER_SETTINGS_FILE
            Rename-Item -Path $settings_file -NewName "${settings_file}.old" -ErrorAction SilentlyContinue
            Invoke-WebRequest -Uri $DOCKER_SETTINGS_URI -OutFile $settings_file
            Write-Host "done." -ForegroundColor Green
            Write-Host ""

            # Remove existing Docker images
            Write-Host "Removing existing Docker Images..." -ForegroundColor Green
            Write-Host ""
            docker rmi -f $(docker image ls -aq); docker system prune -af --volumes
            Out-File -FilePath .dockerclean
            Write-Host ""
            Write-Host "...existing docker images removed." -ForegroundColor Green
            Write-Host ""
        }
    }
    catch {
        handle_error("A Docker setup error occurred, please try again.")
    }
}


# Run Jupyter Launcher
function run_jupyter_launcher() {
    # Download and execute Jupyter Launcher
    Write-Host "Setting up JupyterLab..." -ForegroundColor Green
    Write-Host ""
    try {
        # Download .repo file
        Invoke-WebRequest -Uri $REPO_FILE_URI -OutFile $REPO_FILE

        # Download Jupyter Launcher Script
        Invoke-WebRequest -Uri $JUPYTER_SCRIPT_URI -OutFile $JUPYTER_SCRIPT

        # Run Jupyter Launcher Script
        Invoke-Expression .\$JUPYTER_SCRIPT
        Write-Host ""
        Write-Host "...JupyterLab setup complete." -ForegroundColor Green
        Write-Host ""
    }
    catch {
        handle_error("Unable to setup JupyterLab, please try again.")
    }
}


# Confirm a successful clone operation of the lab repo
function validate_git_repo() {
    Set-Location $ROOT_PATH
    if (-not (Test-Path $REPO_NAME -PathType Container)) {
        handle_error("Aborting due to failed Git Clone.")
    }
}


# Setup YANG Suite
function setup_yang_suite() {
    # Clone YANG Suite repo
    Write-Host "Cloning YANG Suite repository..." -ForegroundColor Green
    Write-Host ""
    try {
        $yang_suite_dir = Test-Path "${ROOT_PATH}\yangsuite" -PathType Container

        if (-not ($yang_suite_dir)) {
            docker exec -it jupyter1 git clone $YANG_SUITE_REPO
        }
        Write-Host ""
        Write-Host "...YANG Suite repository cloned." -ForegroundColor Green
        Write-Host ""
    }
    catch {
        handle_error("Unable to clone YANG Suite repository, please try again.")
    }
    
    try {
        # Download custom configuration data
        Write-Host "Downloading YANG Suite settings..." -NoNewline -ForegroundColor Green
        $yang_suite_settings_path = "${ROOT_PATH}\yangsuite\docker"
        $yang_suite_settings = "${yang_suite_settings_path}\${YANG_SUITE_SETTINGS_FILE}"
        Invoke-WebRequest -Uri $YANG_SUITE_SETTINGS_URI -OutFile $yang_suite_settings -ErrorAction SilentlyContinue
        Write-Host "done." -ForegroundColor Green
        Write-Host ""
    }
    catch {
        handle_error("Unable to download YANG Suite settings, please try again.")
    }

    try {
        # Unzip custom configuration data file
        Write-Host "Applying YANG Suite settings..." -NoNewline -ForegroundColor Green
        Expand-Archive -LiteralPath $yang_suite_settings -DestinationPath $yang_suite_settings_path -ErrorAction SilentlyContinue
        Write-Host "done." -ForegroundColor Green
        Write-Host ""
    }
    catch {
        Write-Warning "Unable to apply YANG Suite settings."
    }

    # Pull YANG Suite Images
    $total_images = $YANG_SUITE_IMAGES.length
    Write-Host "Loading ${total_images} YANG Suite Docker Images..." -ForegroundColor Green
    Write-Host ""
    try {
        $loop_count = 1
        foreach ($image in $YANG_SUITE_IMAGES) {
            Write-Host ""
            Write-Host "Pulling Image ${loop_count} of ${total_images}" -ForegroundColor Green
                docker pull $image
            Write-Host ""
            $loop_count += 1
        }
        Write-Host ""
        Write-Host "...loaded YANG Suite Docker Images." -ForegroundColor Green
        Write-Host ""
    }
    catch {
        handle_error("Unable to pull YANG Suite Images, please try again.")
    }

    # Import custom Docker Compose file
    Write-Host "Importing Docker Compose file..." -NoNewline -ForegroundColor Green
    try {
        $docker_compose_path = "${ROOT_PATH}\yangsuite\docker\"
        $docker_compose_file = $docker_compose_path + $DOCKER_COMPOSE_FILE
        Rename-Item -Path $docker_compose_file -NewName "${docker_compose_file}.old" -ErrorAction SilentlyContinue
        Invoke-WebRequest -Uri $DOCKER_COMPOSE_URI -OutFile $docker_compose_file
        Write-Host "done." -ForegroundColor Green
        Write-Host ""
    }
    catch {
        handle_error("Unable to load Docker Compose file, please try again.")
    }

    # Start YANG Suite Containers
    Write-Host "Starting YANG Suite Containers..." -ForegroundColor Green
    Write-Host ""
    
    try {
        docker-compose -f $docker_compose_file down
        docker-compose -f $docker_compose_file up -d --force-recreate
        Start-Sleep -Seconds $YANG_SUITE_LAUNCH_DELAY
        Write-Host ""
        Write-Host "...YANG Suite Containers started." -ForegroundColor Green
        Write-Host ""
    }
    catch {
        handle_error("Unable to start YANG Suite Containers, please try again.")
    }
    
    # Launch YANG Suite in Chrome
    Write-Host "Opening YANG Suite in a Chrome browser window..." -NoNewline -ForegroundColor Green
    try {
        Start-Process -FilePath "chrome.exe" -ArgumentList "$CHROME_ARGS $YANG_SUITE_URL"
        Write-Host "done." -ForegroundColor Green
    }
    catch {
        handle_error("Unable to launch Chrome, you may manually navigate to the URL: `n${YANG_SUITE_URL}.")
    }
}


# Create link file object
function create_link_obj($link_name, $link_target, $command=$False){
    if ($command) {
        $script_arguments = "-command $ROOT_PATH\$command"
    }
    $shortcut_path = "$ROOT_PATH\Desktop\$link_name"
    $w_script_shell = New-Object -ComObject WScript.Shell
    $shortcut = $w_script_shell.CreateShortcut($shortcut_path)

    if ($script_arguments) {
        $shortcut.Arguments = $script_arguments
        $shortcut.WorkingDirectory = $ROOT_PATH
    }
    $shortcut.TargetPath = $link_target
    $shortcut.save()
}


# Create links to relaunch lab & launch YANG Suite
function create_shortcuts(){
    # Relaunch lab link
    Write-Host ""
    Write-Host "Creating desktop shortcut to restart the lab..." -NoNewline -ForegroundColor Green
    create_link_obj("Restart Lab.lnk")("powershell.exe")("setup_lab.ps1")
    Write-Host "done" -ForegroundColor Green

    # YANG Suite Explorer link
    Write-Host ""
    Write-Host "Creating desktop shortcut to launch YANG Suite..." -NoNewline -ForegroundColor Green
    create_link_obj("YANG Suite.url")($YANG_SUITE_URL)
    Write-Host "done" -ForegroundColor Green
}


# Display exit
function display_exit() {
    Write-Host ""
    Write-Host $FRAME
    Write-Host "** Setup complete **" -ForegroundColor Green
    Write-Host "** Switch to the open Chrome browser to start the lab **" -ForegroundColor Yellow
    Write-Host $FRAME
    Write-Host ""
}


# Main execution
function main() {
    display_intro
    docker_status
    # setup_windows
    setup_docker
    run_jupyter_launcher
    validate_git_repo
    setup_yang_suite
    create_shortcuts
    display_exit
}


# Initiate main execution
main
