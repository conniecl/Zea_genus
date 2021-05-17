open LI,"<list" or die "cannot open the file $!";
$i=1;
while(<LI>)
{
    chomp;
    @tmp=split("_",$_);
    $file=join("_",$tmp[0],$tmp[1]);
    open SNP,"<$tmp[2].fast.final.snps.cluster.vcf" or die "cannot open the file $!";
    open OUT,">$tmp[2].snp.filter.vcf" or die "cannot open the file $!";
    while(<SNP>)
    {
        chomp;
        if($_=~/^#/)
        {
            print OUT "$_\n";
        }
        else
        {
            @array=split("\t",$_);
            $array[7]=~/DP=(.*?);/;
            if($1>=5&&$1<=200&&$array[5]>=20)
            {
                print OUT "$_\n";
            }
        }
    }
        $i++;
    close SNP;
    close OUT;
    system(`ln -s $tmp[2].fast.final.Indel.vcf`);
}
close LI;
