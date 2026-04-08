function bklogin -d "Log in to Booking.com"
    set_color --bold yellow
    echo "======== Running ssh -A ssh.booking.com ========"
    set_color normal

    ssh -A ssh.booking.com; or return 1

    set_color --bold yellow
    echo "======== Running bk auth:login ========"
    set_color normal

    bk auth:login
end
