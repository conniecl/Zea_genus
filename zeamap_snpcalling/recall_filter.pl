#!usr/bin/perl -w
open LI,"<$ARGV[0].snp.filter.vcf" or die "$!";
while(<LI>)
{
    chomp;
	if($_!~/^#/)
	{
	    @tmp=split("\t",$_);
	    if($tmp[-1]=~/\.\/\./)
		{
		     $hash{$tmp[0]}{$tmp[1]}=1;
		}
	}
}
close LI;
open IN,"<$ARGV[0].mo.vcf" or die "cannot open the file $!";
open OUT,">$ARGV[0].recall.filter.vcf" or die "cannot open the file $!";
while(<IN>)
{
    chomp;
    if($_=~/^#/)
    {
        print OUT "$_\n";
    }
    else
    {
        @tmp=split("\t",$_);
        @brray=split(":",$tmp[9]);
        @crray=split("/",$brray[0]);
		if($tmp[6] eq "LowQual")
		{
		    if(exists $hash{$tmp[0]}{$tmp[1]} && $crray[0] eq $crray[1] && $crray[0]==0)
		    {
			    print OUT "$_\n";
			}
		}
		else
		{
            print OUT "$_\n";
        }
    }
}
close IN;
close OUT;
