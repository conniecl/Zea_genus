#!usr/bin/perl -w
open IN,"<merge_all.nomiss.snpeff" or die "cannot open the file $!";
open OUT,">merge_all.nomiss.snpeff.filter" or die "cannot open the file $!";
while(<IN>)
{
    chomp;
    if($_=~/^#/)
    {
        print OUT "$_\n";
    }
    else
    {
        @crray=split("\t",$_);
        $crray[7]=~/ANN=(.*)/;
        @drray=split(",",$1);
        $count=0;
        foreach $in(@drray)
        {
            if($in=~/missense_variant/||$in=~/start_lost/||$in=~/stop_gained/||$in=~/stop_lost/||$in=~/stop_retained_variant/)
            {
                $count++;
            }
        }
        if($count==0)
        {
            print OUT "$_\n";
        }
    }
}
close IN;
close OUT;
