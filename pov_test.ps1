
# Probar

        

          
    
Describe "Pov test cases" {
          

BeforeAll {    
          
    . "./pov.ps1"

}
          

            It "Can reroot a rerooted tree back to the original tree" {
$tree = [Tree]::new("0",   @(  [Tree]::new("1", @([Tree]::new("4"), [Tree]::new("5"))),
[Tree]::new("2", @([Tree]::new("6"), [Tree]::new("7"))) ,
[Tree]::new("3", @([Tree]::new("8"), [Tree]::new("9"))) 
  )
)

$reroot1  = $tree.FromPov("6")
$reroot2  = $reroot1.FromPov("0")  
write-Host "6 POV  $($reroot1 | Select-object -Property Value | ConvertTo-Json -Depth 10)"
write-Host "0 POV: $($reroot2 | ConvertTo-Json -Depth 10)"
$tree | Should BeExactly $reroot2

            }
}