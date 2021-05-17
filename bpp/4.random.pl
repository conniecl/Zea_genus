#!usr/bin/perl -w
%sample=("6F2"=>"Z.nicaraguensis",
         "6F5"=>"Z.nicaraguensis",
         "6F6"=>"Z.nicaraguensis",
         "6F4"=>"Z.nicaraguensis",
         "6F7"=>"Z.nicaraguensis",
         "5D8"=>"Z.nicaraguensis",
         "6F9"=>"Z.nicaraguensis",
         "6F3"=>"Z.nicaraguensis",
         "6E11"=>"Z.nicaraguensis",
         "6F1"=>"Z.nicaraguensis",
         "5D5"=>"Z.luxurians",
         "5D1"=>"Z.perenis",
         "5D2"=>"Z.perenis",
         "5D3"=>"Z.diploperenis",
         "5D7"=>"Z.diploperenis",
         "5D6"=>"Z.huehuetenangensis",
         "6C1"=>"Z.mexicana",
         "6A10"=>"Z.mexicana",
         "5F5"=>"Z.mexicana",
         "5A7"=>"Z.mexicana",
         "6B3"=>"Z.mexicana",
         "6B5"=>"Z.mexicana",
         "6C3"=>"Z.mexicana",
         "5F7"=>"Z.mexicana",
         "6C8"=>"Z.mexicana",
         "6E10"=>"Z.mexicana",
         "5C10"=>"Z.parviglumis",
         "6E2"=>"Z.parviglumis",
         "6H7"=>"Z.parviglumis",
         "6H1"=>"Z.parviglumis",
         "5C9"=>"Z.parviglumis",
         "6H8"=>"Z.parviglumis",
         "6G11"=>"Z.parviglumis",
         "5F9"=>"Z.parviglumis",
         "5C5"=>"Z.parviglumis",
         "5C6"=>"Z.parviglumis",
         "CML479"=>"TST",
         "CML408-M"=>"TST",
         "CML289"=>"TST",
         "CML228"=>"TST",
         "CIMBL98"=>"TST",
         "CIMBL96"=>"TST",
         "CIMBL61X"=>"TST",
         "CIMBL3"=>"TST",
         "CIMBL32"=>"TST",
         "CIMBL28"=>"TST",
         "tri"=>"tripsacum",
         "tdd"=>"tripsacum");
%seq=();
foreach $in(keys %sample)
{
    open IN,"<$in.cds.fa" or die "$!";
    while(<IN>)
    {
        chomp;
        if($_=~/^>/)
        {
            $id=(split/\s+/,$_)[0];
        }
        else
        {
            $seq{$id}{$in}.=$_;
        }
    }
}
@data=();%len=();
foreach $key1(keys %seq)
{
    push @data,$key1;
    $len{$key1}=length($seq{$key1}{"tri"});
    foreach $key2(keys %{$seq{$key1}})
    {
        $seq{$key1}{$key2}=~tr/N/?/;
    }
}
%hash=();
while((keys %hash)<2000)
{
    $hash{int(rand($#data+1))}=1;
}
open OUT,">rand.seq" or die "$!";
foreach $v(keys %hash)
{
    print OUT "48 $len{$data[$v]}\n";
    print "$data[$v]\n";
    print OUT "\n";
    foreach $key2(sort{$a cmp $b} keys %{$seq{$data[$v]}})
    {
        print OUT "^$key2\t\t$seq{$data[$v]}{$key2}\n";
    }
    print OUT "\n";

}
close OUT;
open OUT1,">rand.imap.txt" or die "$!";
foreach $m(keys %sample)
{
    print OUT1 "$m\t$sample{$m}\n";
}
close OUT1;
