#!usr/bin/perl -w
open IN,"<../$ARGV[0]_teo.list" or die "$!";
%pcr=();
while(<IN>)
{
    chomp;
    @tmp=split("\t",$_);
    $pcr{$tmp[0]}=$tmp[1];
}
close IN;
open RE,"<$ARGV[0]_all.format" or die "$!";
$header=<RE>;
chomp($header);
@array=split("\t",$header);
foreach $i(3..$#array)
{
    if(exists $pcr{$array[$i]})
    {
        $name{$i}=$pcr{$array[$i]};
    }
    else
    {
        $name{$i}=$array[$i];
    }
}
while(<RE>)
{
    chomp;
    @brray=split("\t",$_);#print "done.$brray[1].done\n"; exit 0;
    foreach $i(keys %name)
    {
        if($brray[$i] ne "-")
        {
            $pos{$brray[1]}{$name{$i}}=$brray[$i];#print "$brray[1]\t$name{$i}\t$brray[$i]\n";exit 0;
        }
    }
}
close RE;
open SNP,"<merge_2_filter.vcf" or die "$!";
@sample=();
while(<SNP>)
{
    chomp;
    if($_=~/^#CHROM/)
    {
        @sample=split("\t",$_);
    }
    if($_!~/^#/)
    {
        %hash=();
        @crray=split("\t",$_); #print "$crray[1]\n"; exit 0;
        if(exists $pos{$crray[1]})
        {
            @drray=split(",",$crray[4]);
            $hash{0}=$crray[3];
            foreach $i(0..$#drray)
            {
                $hash{$i+1}=$drray[$i];
            }
            foreach $j(9..$#crray)
            {
                if($crray[$j]!~/^\.\/\./)
                {
                    @erray=split/\/|\:/,$crray[$j]; #print "@erray\n"; #exit 0;
                    $alle=join("",$hash{$erray[0]},$hash{$erray[1]}); #print "$alle\n"; exit 0;
                    if(exists $pos{$crray[1]}{$sample[$j]})
                    {
                        if($alle=~/$pos{$crray[1]}{$sample[$j]}/)
                        {
                            $same{$sample[$j]}+=1; print "$crray[1]\t$sample[$j]\t$alle\t$pos{$crray[1]}{$sample[$j]}\tsame\n";
                        }
                        else
                        {
                            $diff{$sample[$j]}+=1; print "$crray[1]\t$sample[$j]\t$alle\t$pos{$crray[1]}{$sample[$j]}\tdiff\n";
                        }
                    }
                }

            }
        }

    }
}
close SNP;
open OUT,">$ARGV[0].consistency\n";
foreach $key(keys %same)
{
    if(exists $diff{$key})
    {
        print OUT "$key\t$same{$key}\t$diff{$key}\n";
        delete($diff{$key});
    }
    else
    {
        print OUT "$key\t$same{$key}\t0\n";
    }
}
foreach $key(keys %diff)
{
    print OUT "$key\t0\t$diff{$key}\n";
}
close OUT;
