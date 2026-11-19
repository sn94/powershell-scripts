<#
. SYNOPSIS
    Given a tree, reorientate it based on a selected node.

. DESCRIPTION
    A tree is a special type of graph where all nodes are connected but there are no cycles.
    That means, there is exactly one path to get from one node to another for any pair of nodes.

    Implement a class to represent the Tree along with these methods:
    - FromPov: accept a value of a node, return a new Tree object orientated based on that node.
        Throw error if the value/node does't exist in the tree.
    - Path: accept the source and destination values of two nodes, return an array of string represent the path from source to destination.
        Throw error if the path doesn't exist.
    - Equals: equality method to compare trees for the test suite.

. EXAMPLE
    Read instructions for visual example.
#>


Class Tree {
[string]$Root = $null;
[string]$Value= $null ;
[Tree[]]$Hijos= $null ;

 Tree([string] $value ) {
    $this.Value = $value; 
    
    }
    Tree([string] $value, [Tree[]] $Children) {
    $this.Value = $value;
    write-host "Build Node ----------- $($value)"
    if( $Children -ne $null){
    foreach($item in $Children ){
    write-host "Add child $($item.Value)"
    $item.Root = $this ;
    write-host "Root of $($item.value) is $($item.Root.value)"
    }
    }
    $this.Hijos = $Children;
    
    }

    [Tree] FromPov([string] $node) {
    
    write-host "POV of ===================== $($node )"
    # fIND node first!
    $encontrado = $null
    if( $this.Value -eq $node){
      
    $encontrado = $this
    }
    write-host "Loop over $($this.Value) children"
    foreach( $nodo in $this.Hijos){
        write-host "Child $($nodo.Value)"
    if( $nodo.Value -eq $node){
    
    # hijos+parent de "node"
    $restTree = @( )
     write-host "Building found tree ... "
   

    if($nodo.Hijos -ne $null){
    $restTree +=  $nodo.Hijos
    write-Host "Add Hijos de $($nodo.Value)" 
    write-host $restTree | select-object Value

    }else{
          write-host "Node $($nodo.Value) doesn't have children"
    }
    if($nodo.Root -ne $null){
    $restTree += $nodo.Root
    write-host "Node $($nodo.Root.Value) is NOT NULL"
    }else{
        write-host "Node $($nodo.Root.Value) is NULL"
    }
   

    $encontrado =  [Tree]::new( $node , $restTree );
    write-Host "Found !!! $($node) - root $( if ($null -ne $nodo.Root.Value) { $nodo.Root.Value } else { 'null' })"
    break;
    }else{
    $encontrado = $nodo.FromPov( $node )
    }
    if($encontrado -ne $null){
    break;
    }
    }#end foreach

        return $encontrado;
    }

    [string[]] Path([string] $from, [string] $to) {
    $path = @(    ) ; 
    $nodo_start= $null ;
    $nodo_end = $null ;

    if( $this.Value -eq $from){
    $nodo_start = $this;
    } elseif( $this.Value -eq $to){
    $nodo_end = $this;
    break;
    } elseif($this.Hijos -ne $null){
    foreach($item in $this.Hijos){
    if( $item.Value -eq $from){
    $nodo_start = $item;
    } elseif( $item.Value -eq $to){
    $nodo_end = $item;
    break;
    }
    
    } #end hijos loop
    } #end elseIf

   $path += $nodo_end.Value ;
   $padre = $nodo_end.Root ;
   while( $padre -ne $null){
    if( $padre.Value -eq $from){
   $path += $padre.Value;
   break;
   } else {
   $path += $padre.Value;
   $padre= $padre.Root;
   }
   }
      return  [Array]::Reverse($path) ;
    }

    [bool] Equals($other) {
    
    #raiz
    #hijos
        if( $other.Value -eq $this.Value){
        return $true;
        }
        else{
        return $false;
        }
    }
}



"""

                            0
                    
                    |       |        |
                    1       2        3
                 |   |    |   |     |  |
                 4   5    6   7     8  9
"""


$tree = [Tree]::new("0",   @(  [Tree]::new("1", @([Tree]::new("4"), [Tree]::new("5")) ),
[Tree]::new("2", @([Tree]::new("6"), [Tree]::new("7"))) ,
[Tree]::new("3", @([Tree]::new("8"), [Tree]::new("9"))) 
  )
)

#$reroot1  = $tree.FromPov("6")
#$reroot2  = $reroot1.FromPov("0")  
#write-Host "reroot1: $($reroot1 | ConvertTo-Json -Depth 10)"

 