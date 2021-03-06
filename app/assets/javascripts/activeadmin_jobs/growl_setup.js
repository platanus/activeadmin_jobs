JobNotifier.onNotify = function(result) {
  DEFAULT_MESSAGES = {
    finished: {
      title: 'Completed Job',
      one: '1 job was successfully completed!',
      other: 'jobs were successfully completed!'
    },
    failed: {
      title: 'Failed Job',
      one: '1 job was completed, but it contains errors...',
      other: 'jobs were completed, but they contains errors...'
    }
  };

  function findTranslation(jobClass, status, key) {
    try {
      var translations = getTranslations();
      return translations[jobClass][status][key];
    } catch(err) {
      console.info('Translation not found. Using default...', jobClass, status, key);
    }

    return DEFAULT_MESSAGES[status][key];
  }

  function camelToDash(str) {
    var parts = str.split('::');
    str = parts[parts.length - 1].replace(/\W+/g, '_');
    return str.replace(/([a-z\d])([A-Z])/g, '$1_$2').toLowerCase();
  }

  function getTranslations() {
    var body = document.querySelector('body');
    return JSON.parse(body.dataset.translations);
  }

  function getJobsUrl() {
    var body = document.querySelector('body');
    return body.dataset.jobsUrl;
  }

  function prepareMessage(job, count) {
    var jobClass = camelToDash(job.job_class);
    var jobsUrl = getJobsUrl();
    var msg = '';

    if(count == 1) {
      jobsUrl += '/' + job.id;
      msg = findTranslation(jobClass, job.status, 'one');
    } else {
      msg = count + ' ' + findTranslation(jobClass, job.status, 'other');
    }

    var link = '<a href="' + jobsUrl + '">' + msg + '</a>';

    return {
      title: findTranslation(jobClass, job.status, 'title'),
      message: link,
      duration: 6000
    };
  }

  function showPopUp(job, count) {
    var msg = prepareMessage(job, count);

    switch(job.status) {
      case 'finished':
        $.growl.notice(msg);
        break;
      case 'failed':
        $.growl.error(msg);
        break;
      default:
        console.error('Invalid job status given', job.status);
    }
  }

  function groupJobsByClass(jobs) {
    var groupedJobs = {};

    for(i = 0; i < jobs.length; i++) {
      var job = jobs[i];

      if(job.status == 'pending') {
        continue;
      }

      var jobClass = camelToDash(job.job_class);

      if(!groupedJobs[jobClass]) {
        groupedJobs[jobClass] = {};
      }

      if(!groupedJobs[jobClass][job.status]) {
        groupedJobs[jobClass][job.status] = [];
      }

      groupedJobs[jobClass][job.status].push(job);
    }

    return groupedJobs;
  }

  function showMsg(jobs) {
    if(jobs.length === 0) {
      return;
    }

    var groupedJobs = groupJobsByClass(jobs);

    for(var jobClass in groupedJobs) {
      if(groupedJobs.hasOwnProperty(jobClass)) {
        for(var status in groupedJobs[jobClass]) {
          if(groupedJobs[jobClass].hasOwnProperty(status)) {
            jobs = groupedJobs[jobClass][status];
            showPopUp(jobs[0], jobs.length);
          }
        }
      }
    }
  }

  showMsg(result);
};
