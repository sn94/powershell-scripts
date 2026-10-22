<#
.SYNOPSIS
    Given a tree, reorientate it based on a selected node.

.DESCRIPTION
    A tree is a special type of graph where all nodes are connected but there are no cycles.
    That means, there is exactly one path to get from one node to another for any pair of nodes.

    Implement a class to represent the Tree along with these methods:
    - FromPov: accept a value of a node, return a new Tree object orientated based on that node.
        Throw error if the value/node does't exist in the tree.
    - Path: accept the source and destination values of two nodes, return an array of string represent the path from source to destination.
        Throw error if the path doesn't exist.
    - Equals: equality method to compare trees for the test suite.

.EXAMPLE
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
    if( $Children -ne $null){
    foreach($item in $Children ){
    $item.Root = $this ;
    }
    }
    $this.Hijos = $Children;
    
    }

    [Tree] FromPov([string] $node) {
    # fIND node first!
    $encontrado = $null
    if( $this.Value -eq $node){
    $encontrado = $this
    }
    foreach( $nodo in $this.Hijos){
    if( $nodo.Value -eq $node){

    # hijos+parent de "node"
    $restTree = @( )
    
    if($node.Hijos -ne $null){
    $restTree +=  $node.Hijos
    }
    if($node.Root -ne $null -and $node.Hijos.Value -contains $node.Root.Value){
    $restTree += $node.Root
    }
    $encontrado =  [Tree]::new( $node , $restTree );
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
