FROM trestletech/plumber
# https://www.rplumber.io/docs/hosting.html#docker

# Copy files from /app in local to /app in the container
ADD /app/ /app/

# Add requirements for testing package
RUN apt-get install -y -q libxml2-dev
RUN mkdir /app/test-result

EXPOSE 8000
CMD ["/app/score.R"]
