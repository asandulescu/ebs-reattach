#   Copyright 2016 Metamarkets Group, Inc.
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.

include:
  - python-pip
  - spottermination

/usr/bin/ebs_start.py:
  file.managed:
    - mode: 0755
    - source: salt://ebs/usr/bin/ebs_start.py

/usr/bin/ebs_stop.py:
  file.managed:
    - mode: 0755
    - source: salt://ebs/usr/bin/ebs_stop.py

/etc/init/ebs.conf:
  file.managed:
    - mode: 0644
    - source: salt://ebs/etc/init/ebs.conf
    - require:
      - pip: ebs_requirements

/etc/init/ebs-shutdown.conf:
  file.managed:
    - mode: 0644
    - source: salt://ebs/etc/init/ebs-shutdown.conf
    - require:
      - pip: ebs_requirements

ebs_requirements:
  pip.installed:
    - require:
      - pkg: python3-pip
    - bin_env: /usr/local/bin/pip3
    - names:
      - boto
      - pyyaml
      - retrying

/etc/spottermination.d/50ebs:
  file.managed:
    - source: salt://ebs/etc/spottermination.d/50ebs
    - mode: 0755