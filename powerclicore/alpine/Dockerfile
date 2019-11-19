FROM mcr.microsoft.com/powershell:alpine-3.8

# Set working directory so stuff doesn't end up in /
WORKDIR /root

# Install VMware modules from PSGallery
SHELL [ "pwsh", "-command" ]
RUN Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
RUN Install-Module VMware.PowerCLI
RUN Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Confirm:$false

CMD ["/usr/bin/pwsh"]
