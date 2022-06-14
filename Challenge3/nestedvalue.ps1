$object = @{
"x"= @{ 
"Y"= @{
"z" = "a"
}
}
}
$object1 = @{
value = @(
@{"x" = "a"}
@{"Y" = "b"}
@{"Z" = "c"}
)
}
function getkeyval
{
$key = $object.x.y.z
write-host "The keypair is" $key
}
getkeyval $object

function getkeyval1
{
$x = $object1.value.x
$y = $object1.value.y
$z = $object1.value.z
Write-host "The value of x is " $x
Write-host "The value of x is " $y
Write-host "The value of x is " $z
}
getkeyval1 $object1