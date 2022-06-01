#!usr/bin/perl -w
open IN,"<Zea_mays.AGPv4.pep.all.fa" or die "$!";
%gene=();%hash=();%loc=();
while(<IN>)
{
    if($_=~/^>/)
    {
        s/>//g;
        $name=(split/\s+/,$_)[0];
        $pos=(split/:/,(split/\s+/,$_)[2],3)[2];
        if($pos=~/^\d/)
        {
            $loc{$name}=$pos;
        }
        $_=~/gene:(.*?)\s/;
        $id=$1;
        push @{$gene{$id}},$name;
    }
    else
    {
        $hash{$name}.=$_;
    }
}
close IN;
open OUT,">B73.max.pep.fa" or die "$!";
open OUT1,">B73.max.pep.loc" or die "$!";
foreach $key1(keys %gene)
{
    $max=0;$max_seq="";$max_name="";
    foreach $key2(@{$gene{$key1}})
    {
        $len=length($hash{$key2});
        if($len>$max)
        {
            $max_seq=$hash{$key2};
            $max_name=$key2;
            $max=$len;
        }
    }
    if(exists $loc{$max_name})
    {
        @array=split/:/,$loc{$max_name};
        print OUT1 "$array[0]\t$array[1]\t$array[2]\t$max_name\n";
        print OUT ">","$max_name\n$max_seq";
    }
    
}
close OUT;
close OUT1;
