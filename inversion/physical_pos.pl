#!usr/bin/perl -w
open IN,"gzip -dc maize_$ARGV[0].gt.vcf.gz|" or die "$!";
#open IN,"<test.vcf" or die "$!";
open OUT,">$ARGV[0]_104.pos" or die "$!";
$count=0;$win=1;$flag=0;
print OUT "$win\t";
while(<IN>)
{
    chomp;
    if($_=~/^\d/)
    {
        @tmp=split("\t",$_,6);
        $len=length($tmp[4]);
        if($len==1)
        {
            if($flag==0)
            {
                print OUT "$tmp[1]\t";
                $flag=1;
            }
            $count++;
            if($count==10000)
            {
                $count=0;$flag=0;
                $win+=1;
                print OUT "$tmp[1]\n$win\t"
            }
            $last=$tmp[1];
        }
    }
}
print OUT "$last\n";
close IN;
close OUT;
