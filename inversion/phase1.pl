#!usr/bin/perl -w
@file=glob("*.matrix1");
%hash=();
foreach $in(@file)
{
    if($in=~/\d/)
    {
        open IN,"<$in" or die "$!";
        $pop=(split/\./,$in)[1];
        while(<IN>)
        {
            chomp;
            @tmp=split("\t",$_);
            $tmp[0]=join(".",$tmp[0],$pop);
            $hash{$tmp[0]}{$tmp[3]}=join("\t",$tmp[1],$tmp[2],$tmp[4],$tmp[5]);
        }
        close IN;
    }
}
%inv=();
foreach $key1(keys %hash)
{
    foreach $key2(keys %{$hash{$key1}})
    {
        print "$key1.$key2\n";
        open FI,"<$key1/$key1.$key2" or die "$!";
        readline FI;
        while(<FI>)
        {
            chomp;
            s/\"//g;
            @array=split/\s+/,$_;
            if($array[0]=~/\./)
            {
                @brray=split/\./,$array[0];
                if($brray[0] eq $brray[1])
                {
                    $name=$brray[0];
                }
                else
                {
                    $name=join("_",$brray[0],$brray[1]);
                }
            }
            else
            {
                $name=$array[0];
            }
            $test=join(".",$key1,$key2);
            if($array[1]>0.8)
            {
                $inv{$test}{$name}="NI";
            }
            elsif($array[2]>0.8)
            {
                $inv{$test}{$name}="he";
            }
            elsif($array[3]>0.8)
            {
                $inv{$test}{$name}="I";
            }
            else
            {
                $inv{$test}{$name}="NA";
            }
        }
        close FI;
    }
}
foreach $m(keys %inv)
{
    $ref=$inv{$m}{"B73"};
    @file=split/\./,$m;
    if(!exists $fh{$file[1]})
    {
        open $fh{$file[1]},">$file[1].phase1" or die "$!";
    }
    if($ref eq "NI")
    {
        $test=join(".",$file[0],$file[1]);
        $fh{$file[1]}->print("$file[0]\t$hash{$test}{$file[2]}\t");
        foreach $n(sort{$a cmp $b} keys %{$inv{$m}})
        {
            if($n ne "B73")
            {
                if($inv{$m}{$n} eq "NI")
                {
                    $fh{$file[1]}->print("0\t");
                }
                elsif($inv{$m}{$n} eq "I")
                {
                    $fh{$file[1]}->print("2\t");
                }
                elsif($inv{$m}{$n} eq "he")
                {
                    $fh{$file[1]}->print("1\t");
                }
                else
                {
                    $fh{$file[1]}->print("NA\t");
                }
            }
        }
        $fh{$file[1]}->print("\n");
    }
    if($ref eq "I")
    {
        $test=join(".",$file[0],$file[1]);
        $fh{$file[1]}->print("$file[0]\t$hash{$test}{$file[2]}\t");
        foreach $n(sort{$a cmp $b} keys %{$inv{$m}})
        {
            if($n ne "B73")
            {
                if($inv{$m}{$n} eq "NI")
                {
                    $fh{$file[1]}->print("2\t");
                }
                elsif($inv{$m}{$n} eq "I")
                {
                    $fh{$file[1]}->print("0\t");
                }
                elsif($inv{$m}{$n} eq "he")
                {
                    $fh{$file[1]}->print("1\t");
                }
                else
                {
                    $fh{$file[1]}->print("NA\t");
                }
            }
        }
        $fh{$file[1]}->print("\n");
    }
}
