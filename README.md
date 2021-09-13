# Oso Ruby Quickstart

Follow along [here](https://docs.osohq.com/ruby/getting-started/quickstart.html).

## Instructions

1. Clone this repository.
2. Install dependencies: `bundle install`
3. Run the server: `bundle exec ruby server.rb`

## Make some changes

If you visit
[http://localhost:5000/repo/gmail](http://localhost:5000/repo/gmail), you
should get a 200 response. If you visit
[http://localhost:5000/repo/react](http://localhost:5000/repo/react), you
should see a 404.

Add this code to `main.polar`:
```python
has_permission(_, "read", repository: Repository) if
  repository.is_public;
```

Now, when you visit
[http://localhost:5000/repo/react](http://localhost:5000/repo/react), you should
see a proper 200 response, because the `react` repository is marked as public
in `models.rb`.
