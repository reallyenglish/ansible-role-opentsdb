ansible-role-opentsdb
=====================

Install opentsdb

Requirements
------------

java.net.InetAddress.getLocalHost throws an exception when hostname is not in /etc/hosts or unresolvable. Add a record in /etc/hosts or your DNS.

Role Variables
--------------

| variable | description | default |
|----------|-------------|---------|
| opentsdb\_user | user of tsdb | opentsdb |
| opentsdb\_group | group of tsdb | opentsdb |
| opentsdb\_log\_dir | path to log dir | /var/log/opentsdb |
| opentsdb\_service | service name of tsdb | opentsdb |
| opentsdb\_conf | path to opentsdb.conf | "{{ \_\_opentsdb\_conf }}" |
| opentsdb\_conf\_dir | path to the config dir | "{{ \_\_opentsdb\_conf\_dir }}" |
| opentsdb\_flags | not used yet | "" |
| opentsdb\_tsd\_http\_cachedir | tsd.http.cachedir | /tmp/opentsdb |
| opentsdb\_config | content of opentsdb.conf | "" |
| opentsdb\_log\_config | content of logback.xml | "" |
| opentsdb_populate_database | if true, populate the hbase with create\_table.sh | true |
| opentsdb\_hbase\_comand | path to habse command | "{{ \_\_opentsdb\_hbase\_comand }}" |
| opentsdb\_hbase\_flags | a string of flags to pass hbase command | "" |
| opentsdb\_hbase\_home | env of HBASE\_HOME when running hbase command | "{{ \_\_opentsdb\_hbase\_home }}" |
| opentsdb\_hbase\_list\_command | a string of command to show list of tables | "list" |
| opentsdb\_create\_table | path to create\_table.sh bundled with opentsdb | "{{ \_\_opentsdb\_create\_table }}" |

Dependencies
------------

- ansible-role-hbase

Example Playbook
----------------

    - hosts: all
      roles:
        - ansible-role-hbase
        - ansible-role-opentsdb
      vars:
        hbase_site_xml: |
          <property>
            <name>hbase.rootdir</name>
            <value>file://{{ hbase_db_dir }}</value>
          </property>
          <property>
            <name>hbase.zookeeper.property.dataDir</name>
            <value>/var/db/zookeeper</value>
          </property>
        opentsdb_config: |
          tsd.network.bind = 0.0.0.0
          tsd.network.port = 4242
          tsd.http.staticroot = /usr/local/share/opentsdb/static
          tsd.http.cachedir = {{ opentsdb_tsd_http_cachedir }}
          tsd.storage.hbase.zk_quorum = localhost

License
-------

BSD

Author Information
------------------

An optional section for the role authors to include contact information, or a website (HTML is not allowed).
