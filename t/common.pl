use Test::More;

# assumes suitable class setup before call
sub run_struct_tests {
  my $o = Inline::Struct::Foo->new->inum(10)->dnum(3.1415)->str('Wazzup?');
  $o->inum(10);
  $o->dnum(3.1415);
  $o->str('Wazzup?');
  my %vals = (inum => 10, dnum => 3.1415, str => 'Wazzup?');
  is $o->$_(), $vals{$_}, $_ for @{$o->_KEYS};
  is_deeply $o->_HASH, { qw(inum 10 dnum 3.1415 str Wazzup?) }, '_HASH method';
  is_deeply $o->_KEYS, [ qw(inum dnum str) ], '_KEYS method';
  is_deeply $o->_VALUES, [ qw(10 3.1415 Wazzup?) ], '_VALUES method';
}

1;

__END__
$o->Print;

package Inline::Struct::Foo;
sub Print {
    my $o = shift;
    print "Foo {\n" . (join "\n", map { "\t".$o->$_() } @{$o->_KEYS}) . "\n}\n";
}
