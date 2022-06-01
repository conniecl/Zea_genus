#!usr/bin/perl -w
open FA,"<../select_repeat.fa" or die "$!";
%fa=();
while(<FA>)
{
    chomp;
    if($_=~/^>/)
    {
        s/>//g;
        $id=$_;
    }
    else
    {
        $fa{$id}.=$_;
    }
}
close FA;
foreach $key(keys %fa)
{
    $len=length($fa{$key});
    $fa{$key}=$len;
}
open LI,"</public/home/lchen/zeamap/31.data_add/03.teo_raw/trim/list" or die "$!";
%hash=();@sample=();$te=();
while(<LI>)
{
    chomp;
    @name=split("\t",$_);
    %sum=();%type=();
    foreach $i(0..$name[1])
    {
        open IN,"<$name[0].$i.te.static" or die "$!";
        readline IN;
        while(<IN>)
        {
            chomp;
            @tmp=split("\t",$_);
            $sum{$tmp[0]}+=$tmp[1];
            $type{$tmp[0]}=$tmp[-1];
            $te{$tmp[-1]}=1;
        }
        close IN;
    }
    foreach $key(keys %sum)
    {
        #$avg=$sum{$key}/$fa{$key};
        $hash{$name[0]}{$type{$key}}+=$sum{$key};
    }
    push @sample,$name[0];
}
close LI;
open FI,"<../maize_id" or die "$!";
while(<FI>)
{
    chomp;
    @name=split("\t",$_);
    push @sample,$name[1];
    open IN,"<$name[1].te.static" or die "$!";
    readline IN;
    while(<IN>)
    {
        chomp;
        @tmp=split("\t",$_);
        #$avg=$tmp[1]/$fa{$tmp[0]};
        $hash{$name[1]}{$tmp[-1]}+=$tmp[1];
        $te{$tmp[-1]}=1;
    }
    close IN;
}
close FI;
@tes=keys %te;
open OUT,">zea_te.matrix" or die "$!";
print OUT "\t";
foreach $i(@tes)
{
    print OUT "$i\t";
}
print OUT "\n";
foreach $key1(@sample)
{
	print OUT "$key1\t";
    foreach $key2(@tes)
    {
        if(exists $hash{$key1}{$key2})
        {
            print OUT "$hash{$key1}{$key2}\t";
        }
        else
        {
            print OUT "0\t";
        }
    }
    print OUT "\n";
}
close OUT;
