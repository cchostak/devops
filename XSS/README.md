# Cross Site Scripting

Injection Context
When untrusted data is used by an application, it is often inserted into a command, document, or other structure. We will call this the injection context. For example, consider a SQL statement constructed with “SELECT * FROM users WHERE name=’” + request.getParameter( “name” ) + “’”; In this example, the name is data from a potentially hostile user, and so could contain an attack. But the attack is constrained by the injection context. In this case, inside single quotes (‘). That’s why single quotes are so important for SQL injection.

Consider a few of the types of commands and documents that might allow for injection…

SQL queries
LDAP queries
Operating system command interpreters
Any program invocation
XML documents
HTML documents
JSON structures
HTTP headers
File paths
URLs
A variety of expresson languages
etc…

https://cheatsheetseries.owasp.org/cheatsheets/Cross_Site_Scripting_Prevention_Cheat_Sheet.html