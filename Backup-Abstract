#Full Backup
#  Setup folder structure
#    rename Current-Week to Temporary
#    rename Last-Week to Current-Week
#    rename Temp-Week to Last-Week
Move-Item $Backup-Server\Backup\Current-Week $Backup-Server\Backup\Temp-Week
Move-Item $Backup-Server\Backup\Last-Week $Backup-Server\Backup\Current-Week
Move-Item $Backup-Server\Backup\Temp-Week $Backup-Server\Backup\Last-Week
#    remove FileShare from each day in Current-Week
#    remove all subdirectories
#    delete directories without require confirmation
Get-ChildItem -Path $Backup-Server\Backup\Current-Week\Monday\FileShare\* -Recurse | Remove-Item
Get-ChildItem -Path $Backup-Server\Backup\Current-Week\Tuesday\FileShare\* -Recurse | Remove-Item
Get-ChildItem -Path $Backup-Server\Backup\Current-Week\Wednesday\FileShare\* -Recurse | Remove-Item
Get-ChildItem -Path $Backup-Server\Backup\Current-Week\Thursday\FileShare\* -Recurse | Remove-Item
Get-ChildItem -Path $Backup-Server\Backup\Current-Week\Friday\FileShare\* -Recurse | Remove-Item
Get-ChildItem -Path $Backup-Server\Backup\Current-Week\Saturday\FileShare\* -Recurse | Remove-Item
#  Start backup
#    map Drive-Letter to File-Server
New-PSDrive -Name $Drive-Letter -PSProvider FileSystem -Root $File-Server\FileShare
#    robocopy Drive-Letter to Current-Week\Full, copy all file info, retry twice, wait 10sec, exclude dir *DfsrPrivate, mirror destination directory, delete as needed, no copy progress % displayed, overwrite Current-Week\Full\Full.log, no directory list logging, output to console and log file, verbose log
robocopy $Drive-Letter $Backup-Server\Backup\Current-Week\Full\FileShare /COPYALL /R:2 /W:10 /XD *DfsrPrivate /MIR /NP /LOG:"$Backup-Server\Backup\Current-Week\Full\Full.log" /NDL /TEE /V
#[tbd] if pathname too long, New-PSDrive @ 1 level above lowest, recopy, exit back to script?
#    remove archive bit from all files in all subfolders
#    delete Drive-Letter
attrib -A $Drive-Letter*.* /S
net use $Drive-Letter /DELETE
#  Report success
#   blat email.txt to admins
blat "\\example.com\filesrv\backup\email_example-full.txt" -to sysadmin@example.com -f backup@example.com -subject "Backup Job FULL Completed" -server smtp.example.com
#  Log folder size
#    du append to robocopy log

#Incremental Backups
#  Start backup
#    map Drive-Letter to File-Server
#    robocopy Drive-Letter to Current-Week-day
#      copyall
#      mirror
#       only copy archive-bit files
