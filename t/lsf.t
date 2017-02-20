use Test::More ;
#######################
# LSF
#######################
require_ok('LSF');
ok(length(LSF->LSF()>0),"LSF Returned some version string");
#######################
# LSF Queues
#######################
require_ok('LSF::Queue');
@qinfo = LSF::Queue->new();
diag explain @qinfo;
foreach my $q (@qinfo){
	if ($q->{STATUS} eq 'Open:Active'){
		$queueName=$q->{QUEUE};
		last;
	}
}
ok(length($queueName)>0,"Queues available on machine");
#######################
# LSF
#######################
require_ok('LSF::Job');
my $job=LSF::Job->submit(-q => $queueName ,-o => '/dev/null' ,"echo hello");
ok($job->id,"Submission of Job to Queue ok");

#######################
# LSF
#######################
require_ok('LSF::JobManager');
my $m = LSF::JobManager->new(-q=>$queueName);
my $job = $m->submit("echo hello");
ok($job->id,"Submission of Job to Queue ok");
done_testing;
