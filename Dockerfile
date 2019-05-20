FROM trestletech/plumber

# Trying to add the three files below to root dir in docker container, then make it run score.R

# https://www.rplumber.io/docs/hosting.html#docker
# Update 1/14/2019 11:35AM
# Update 1/14/2019 12:12PM
# Update 1/14/2019 12:24PM
# Update 1/18/2019 - KC DEMO
# Update 5/17 add environment variables

ADD docker/* /app/

EXPOSE 8000
CMD ["/app/score.R"]