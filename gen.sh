#!/bin/sh
# Copyright (c) 2024 Nicolas Paul.  All rights reserved.
# Use of this source file is governed by the Nicolas Paul
# Public License, Version 1.0, present in the COPYRIGHT file.

cat <<EOF > index.html
<!DOCTYPE html>
<!-- Copyright (c) 2024 Nicolas Paul.  All rights reserved.
     Use of this source file is governed by the Nicolas Paul
     Public License, Version 1.0, present in the COPYRIGHT file. -->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<p>
    Index of <a href="https://go.nc0.fr">go.nc0.fr</a>.
<ul>
EOF

while read line; do
    name=`echo $line | cut -d' ' -f1`
    vcs=`echo $line | cut -d' ' -f2`
    repo=`echo $line | cut -d' ' -f3`
    file=`echo $line | cut -d' ' -f4`
    dir=`echo $line | cut -d' ' -f5`

    import="go.nc0.fr/$name"

    cat <<EOF > $name.html
    <!DOCTYPE html>
    <!-- Copyright (c) 2024 Nicolas Paul.  All rights reserved.
         Use of this source file is governed by the Nicolas Paul
         Public License, Version 1.0, present in the COPYRIGHT file. -->
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="go-import" content="$import $vcs $repo">
    <meta name="go-source" content="$import $file $dir">
    <meta http-equiv="refresh" content="0; url=https://pkg.go.dev/$import"/>
    <p>
        Redirecting to <a href="https://pkg.go.dev/$import">https://pkg.go.dev/$import</a>.
EOF

    echo "<li><a href=\"$name.html\">$name</a>" >> index.html
done < $1

echo '</ul>' >> index.html
