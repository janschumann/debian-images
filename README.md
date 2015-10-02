# debian-images
Some packer templates for building vagrant vmware/virtualbox and EC2 AMI images based on debian.

## Build an image

To build images, you will beed to install [packer](https://www.packer.io/downloads.html) and clone this repo.

### Vagrant vmware/virtualbox

NOTE that the debian7 vagrant box already available on Atlas (Vagrant Cloud) (https://atlas.hashicorp.com/janschumann/boxes/debian7-puppet4-base)

* Install [vagrant](https://www.vagrantup.com/downloads.html)
* Install [virtualbox](https://www.virtualbox.org/wiki/Downloads) or [vmware](http://store.vmware.com/store/vmwde/home)
* NOTE that virtual box provider is included in vagrant while vmware provider is not open source and not included. The vmware provider can be purchased [here](https://www.vagrantup.com/vmware#buy-now)

*Build and install*

```
$ cd /path/to/checkout
$ packer build -only=virtualbox-iso debian7-puppet-4-base.json
$ vagrant box add my-box-name 
```

* To build for vmware replace virtualbox-iso with vmware-iso.
* To build debian jessie replace debian7-puppet-4-base.json with debian8-puppet-4-base.json

Alternatively you can also use [Atlas](https://atlas.hashicorp.com) to build those images. 

* Create an account
* Create an [API token](https://atlas.hashicorp.com/settings/tokens) 
* Issue `export ATLAS_TOKEN=your-token`
* Issue `packer push debian7-puppet-4-base.json`

This will trigger the build automaically and after a while, the images appear in [Vagrant Cloud](https://atlas.hashicorp.com/vagrant)

NOTE that the templates also include a build for AMI images. These will fail to build, as AWS access keys are not included in the template. These have to be added in atlas as variables. https://atlas.hashicorp.com/account name>/build-configurations/debian7-puppet4-base/variables

*Start the machine*

```
$ vagrant init my-box-name
$ vagrant up
$ vagrant ssh
```

or use the cloud image

```
$ vagrant init janschumann/debian7-puppet-4-base
$ vagrant up
$ vagrant ssh
```

### AWS 

To use the same base to launch instances on EC2, you can create AMI images from these templates.

First you will have to find an AMI image to use as base installation. To build debian7 in eu-central-1 the base AMI would be ami-98043785.

Other source AMI´s can be found here: https://wiki.debian.org/Cloud/AmazonEC2Image. Make sure you select `hvm x86_64 ebs` and the correct region.

```
$ export AWS_ACCESS_KEY_ID="your key id"
$ export AWS_SECRET_ACCESS_KEY="your key"
$ export AWS_REGION="your region"
$ export AWS_SOURCE_AMI="the select ami id"
$ packer build -only=amazon-ebs debian7-puppet-4-base.json
```

Now you can launch an instance of the resultin AMI.


## Contributing

1. Fork it ( https://github.com/janschumann/debian-images)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
