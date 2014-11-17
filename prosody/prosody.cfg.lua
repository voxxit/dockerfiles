-- Prosody XMPP Server Configuration
--
-- Information on configuring Prosody can be found on our
-- website at http://prosody.im/doc/configure
--
-- Tip: You can check that the syntax of this file is correct
-- when you have finished by running: luac -p prosody.cfg.lua
-- If there are any errors, it will let you know what and where
-- they are, otherwise it will keep quiet.
--
-- Good luck, and happy Jabbering!


---------- Server-wide settings ----------
-- Settings in this section apply to the whole server and are the default
-- settings for any virtual hosts

-- This is a (by default, empty) list of accounts that are admins
-- for the server. Note that you must create the accounts separately
-- (see http://prosody.im/doc/creating_accounts for info)
-- Example: admins = { "user1@example.com", "user2@example.net" }
admins = { }

-- Enable use of libevent for better performance under high load
-- For more information see: http://prosody.im/doc/libevent
use_libevent = true;

-- This is the list of modules Prosody will load on startup.
-- It looks for mod_modulename.lua in the plugins folder, so make sure that exists too.
-- Documentation on modules can be found at: http://prosody.im/doc/modules

modules_enabled = {

	-- Generally required
		"roster";         -- Allow users to have a roster. Recommended ;)
		"saslauth";       -- Auth for clients/servers.
		"tls";            -- Add support for secure TLS on c2s/s2s connections
		"dialback";       -- s2s dialback support
		"disco";          -- Service discovery
		"posix";

	-- Not essential, but recommended
		--"private";      -- Private XML storage (for room bookmarks, etc.)
	  --"vcard";        -- Allow users to set vCards

	-- These are commented by default as they have a performance impact
		--"privacy";      -- Support privacy lists
		--"compression";  -- Stream compression (requires the lua-zlib package)

	-- Nice to have
		--"version";      -- Replies to server version requests
		--"uptime";       -- Report how long server has been running
		--"time";         -- Let others know the time here on this server
		--"ping";         -- Replies to XMPP pings with pongs
		--"pep";          -- Enables users to publish their mood, activity, etc.
		--"register";     -- Allow registration using client, etc.

	-- Admin interfaces
		--"admin_adhoc";  -- Allows admin via an XMPP client
		--"admin_telnet"; -- Opens telnet console interface on localhost:5582

	-- HTTP modules
		"bosh";						-- Enable BOSH clients, aka "Jabber over HTTP"
		--"http_files"; 	-- Serve static files from a directory over HTTP

	-- Other specific functionality
		--"groups";
		--"announce";
		--"welcome";
		--"watchregistrations";
		--"motd";
		--"legacyauth";
};

-- These modules are auto-loaded, but should you want
-- to disable them then uncomment them here:

modules_disabled = {
	-- "offline"; -- Store offline messages
	-- "c2s"; -- Handle client connections
	-- "s2s"; -- Handle server-to-server connections
};

-- Disable account creation by default, for security
-- For more information see http://prosody.im/doc/creating_accounts
allow_registration = false;

-- These are the SSL/TLS-related settings. If you don't want
-- to use SSL/TLS, you may comment or remove this
--ssl = {
--	key = "/data/certs/localhost.key";
--	certificate = "/data/certs/localhost.crt";
--}

-- Force clients to use encrypted connections? This option will
-- prevent clients from authenticating unless they are using encryption.
c2s_require_encryption = false

-- Force certificate authentication for server-to-server connections?
-- This provides ideal security, but requires servers you communicate
-- with to support encryption AND present valid, trusted certificates.
-- NOTE: Your version of LuaSec must support certificate verification!
-- For more information see http://prosody.im/doc/s2s#security
s2s_secure_auth = false

-- Many servers don't support encryption or have invalid or self-signed
-- certificates. You can list domains here that will not be required to
-- authenticate using certificates. They will be authenticated using DNS.

--s2s_insecure_domains = { "gmail.com" }

-- Even if you leave s2s_secure_auth disabled, you can still require valid
-- certificates for some domains by specifying a list here.

--s2s_secure_domains = { "jabber.org" }

-- Required for init scripts and prosodyctl
pidfile = "/data/prosody.pid"

-- Select the authentication backend to use. The 'internal' providers
-- use Prosody's configured data storage to store the authentication data.
-- To allow Prosody to offer secure authentication mechanisms to clients, the
-- default provider stores passwords in plaintext. If you do not trust your
-- server please see http://prosody.im/doc/modules/mod_auth_internal_hashed
-- for information about using the hashed backend.
authentication = "internal_plain"

-- Select the storage backend to use. By default Prosody uses flat files
-- in its configured data directory, but it also supports more backends
-- through modules. An "sql" backend is included by default, but requires
-- additional dependencies. See http://prosody.im/doc/storage for more info.
storage = "sql"

sql = { driver = "SQLite3", database = "/data/prosody.sqlite" }
--sql = { driver = "MySQL", database = "prosody", username = "prosody", password = "secret", host = "localhost" }
--sql = { driver = "PostgreSQL", database = "prosody", username = "prosody", password = "secret", host = "localhost" }

-- Logging configuration
-- For advanced logging see http://prosody.im/doc/logging
log = "*console"

-- Don't daemonize; this is Docker!
daemonize = false

-- Need at least one to function.
VirtualHost "localhost"
