// derive-names-onCreateNode.js
//
// Bound (via behaviour-derive-names-context.xml) to the onCreateNode policy for cm:person.
// Runs once, right after a new person node is created (e.g. by LDAP synchronization).
//
// If cm:firstName is blank while cm:lastName is populated (or vice versa), the populated
// value is copied into the blank property so the user never shows up with a totally empty
// name field in Share. If BOTH are blank, falls back to cm:userName.

function isBlank(value) {
    return (value == null || ("" + value).replace(/^\s+|\s+$/g, "") == "");
}

if (behaviour.args != null && behaviour.args.length == 1) {
    var childAssoc = behaviour.args[0];
    var person = childAssoc.child;

    if (person != null && person.properties["cm:userName"] != null) {
        var firstName = person.properties["cm:firstName"];
        var lastName = person.properties["cm:lastName"];
        var userName = person.properties["cm:userName"];

        var firstBlank = isBlank(firstName);
        var lastBlank = isBlank(lastName);

        if (firstBlank && !lastBlank) {
            person.properties["cm:firstName"] = lastName;
            person.save();
            logger.log("[derive-names] " + userName + ": blank firstName derived from lastName '" + lastName + "'");
        } else if (lastBlank && !firstBlank) {
            person.properties["cm:lastName"] = firstName;
            person.save();
            logger.log("[derive-names] " + userName + ": blank lastName derived from firstName '" + firstName + "'");
        } else if (firstBlank && lastBlank) {
            person.properties["cm:firstName"] = userName;
            person.properties["cm:lastName"] = userName;
            person.save();
            logger.log("[derive-names] " + userName + ": both names blank, defaulted to username");
        }
    }
}

