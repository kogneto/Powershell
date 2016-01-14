$dir = #path to parent directory like "f:\projects"
$log = #path to log file like "d:\old-projects.txt"
$folders = Get-ChildItem -Path $dir
foreach ($folder in $folders)
{
  $truth = "true"
  if ($folder.Attributes -eq “Directory”)
  {
    write-host "Searching " $folder
    $files = Get-ChildItem ($dir + $folder) -recurse 
    foreach ($file in $files)
    {
        if (!$file.PsIsContainer -AND $file.LastWriteTime -gt (Get-Date).AddDays(-180))
        {
          write-host "Found new file: " $file
          $truth = "false"
          break
        }
    }
  }
  if ($truth -eq "true") {$folder.name >> $log}
}
