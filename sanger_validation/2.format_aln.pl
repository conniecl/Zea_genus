#!usr/bin/perl -w
open IN,"<$ARGV[0].aln" or die "$!";
open OUT,">$ARGV[0].format" or die "$!";
print OUT "chr\tpos\tref\t";
while(<IN>)
{
    chomp;
    if($_=~/^>/)
    {#$c++;
        s/>//g;
        $id=$_;
        if($.!=1)
        {
            push @noref,$id;
            if($id=~/_/)
            {
                $temp=(split"_",$id)[0];
            }
            else
            {
                $temp=$id;
            }
            print OUT "$temp\t";
        }
        else
        {
            $refid=$id;
        }
    }
    else
    {
        $hash{$id}.=$_;
    }
}
close IN;
foreach $key(keys %hash)
{
    @array=split("",$hash{$key});
    foreach $i(0..$#array)
    {
        $pos{$i}{$key}=$array[$i];
    }
    #$c++;
}
#print "$c\n"; exit 0;
print OUT "\n";
@brray=split("_",$refid);
$position=$brray[1];$f=1;
foreach $key1(sort{$a<=>$b} keys %pos)
{$f++;
    if($pos{$key1}{$refid} ne "-")
    {
        $position++;
        print OUT "$brray[0]\t$position\t$pos{$key1}{$refid}\t";
        foreach $key2(@noref)
        {
            print OUT "$pos{$key1}{$key2}\t";
        }
        print OUT "$f\n";
    }
}
close OUT;
