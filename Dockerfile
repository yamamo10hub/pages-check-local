FROM    jekyll/jekyll

RUN     echo "source 'https://rubygems.org'" > Gemfile && \
        echo "gem 'github-pages', group: :jekyll_plugins" >> Gemfile && \
        bundle install && \
        rm -f Gemfile Gemfile.lock
RUN     mkdir /srv/src
EXPOSE  4000
WORKDIR /srv/src
CMD     ["bundle", "exec", "jekyll", "serve", "--destination", "/srv/jekyll", "--host", "0.0.0.0"]
