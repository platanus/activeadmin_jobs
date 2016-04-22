# Active Admin Jobs

It's a Rails engine that allows you to play nice with [Active Job](https://github.com/rails/activejob) in [Active Admin](https://github.com/activeadmin/activeadmin) providing user feedback. It uses [Job Notifier](https://github.com/platanus/job_notifier) gem and includes:

- An endpoint to a view with a jobs list.
- A DSL that allows you to catch a `JobNotifier::Job` instance `response` to build success/error HTML views.
- The mechanism to listen job status changes and notify them.

## Installation

Add to your Gemfile:

```ruby
gem "activeadmin_jobs"
```

```bash
bundle install
```

## Usage

TODO

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Credits

Thank you [contributors](https://github.com/platanus/activeadmin_jobs/graphs/contributors)!

<img src="http://platan.us/gravatar_with_text.png" alt="Platanus" width="250"/>

Active Admin Jobs is maintained by [platanus](http://platan.us).

## License

Active Admin Jobs is © 2016 platanus, spa. It is free software and may be redistributed under the terms specified in the LICENSE file.
