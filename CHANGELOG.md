# Change Log
All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

### v0.2.1

#### Fixed

- Filter jobs by identifier.

### v0.2.0

#### Added

- Add .travis.yml with config to deploy on tag creation.

#### Removed

- Remove useless notified column from index/show job's views.

#### Security

- Avoid CSRF issue executing protect_from_forgery in Application Controller.

### v0.1.2

#### Fixed

- Run job_notifier installer from this gem's installer.

### v0.1.1

#### Fixed

- Remove unreachable growl gem from gemspec.

### v0.1.0

- Initial release.
