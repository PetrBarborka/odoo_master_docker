FROM debian:jessie
MAINTAINER Petr Barborka <github.com/PetrBarborka>

# Install some deps, lessc and less-plugin-clean-css, and wkhtmltopdf
ADD pkglist /
ADD install_wkhtmltox.sh /
RUN set -x; \
        apt-get update \
        && apt-get install -y --no-install-recommends $(cat pkglist) \
        && ./install_wkhtmltox.sh

ADD requirements.txt /
#RUN pip3 install --upgrade setuptools
RUN pip3 install -r requirements.txt
#RUN pip install pyOpenSSL

# explicitly set user/group IDs
RUN groupadd -r odoo --gid=1000 && useradd -r -g odoo --uid=1000 odoo

# Copy entrypoint script and Odoo configuration file
COPY ./entrypoint.sh /
COPY ./odoo.conf /etc/odoo/
RUN chown odoo /etc/odoo/odoo.conf

# Mount /var/lib/odoo to allow restoring filestore and /mnt/extra-addons for users addons
RUN mkdir -p /mnt/extra-addons \
    && chown -R odoo /mnt/extra-addons

RUN mkdir /var/lib/odoo \
    && chown odoo:odoo /var/lib/odoo \
    && chown -R odoo:odoo /opt\
    && chmod ugo+x /entrypoint.sh \
    && chown odoo:odoo /entrypoint.sh

VOLUME ["/var/lib/odoo", "/mnt", "/opt/odoo", "/mnt/extra-addons"]

# Expose Odoo services
EXPOSE 8069 8071

# Set the default config file
ENV ODOO_RC /etc/odoo/odoo.conf
ENV LANG C.UTF-8

# Set default user when running the container
USER odoo

ENTRYPOINT ["/entrypoint.sh"]
ARG CACHEBUST=1
CMD ["-c", "/etc/odoo/odoo.conf"]
