#!/bin/bash	

# Lay thong tin he dieu hanh
get_os_info() {
    echo "--- THONG TIN HE DIEU HANH ---"
    uname -a
    echo ""
}

# Lay thoi gian he thong
get_time_info() {
    echo "--- THOI GIAN HE THONG ---"
    date "+Ngay %d/%m/%Y - %H:%M:%S"
    echo ""
}

# Lay thong tin RAM
get_ram_info() {
    echo "--- THONG TIN BO NHO (RAM) ---" 
    local total_ram=$(free -h --si | awk 'NR==2 {print $2}')
    # Sua lay du lieu RAM trong o dong 2, cot 4
    local free_ram=$(free -h --si | awk 'NR==2 {print $4}')
    echo "Tong dung luong RAM: $total_ram"
    echo "RAM con trong      : $free_ram"
    echo ""
}

# Lay thong tin phan cung CPU
get_cpu_info() {
    echo "--- THONG TIN PHAN CUNG (CPU) ---"
    local cpu_name=$(sudo lshw -class processor 2>/dev/null | grep -m 1 "product:" | awk -F': ' '{print $2}')    
    if [ -z "$cpu_name" ]; then
        echo "Ten CPU: (Can quyen sudo de hien thi)"
    else
        echo "Ten CPU: $cpu_name"
    fi
    echo ""
}

# Lay thong tin o dia
get_disk_info() {
    echo "--- THONG TIN O DIA (DISK) ---"
    local total_disk=$(df -h / | awk 'NR==2 {print $2}')
    local used_disk=$(df -h / | awk 'NR==2 {print $3}')
    local free_disk=$(df -h / | awk 'NR==2 {print $4}')
    local dir_size=$(du -sh . 2>/dev/null | awk '{print $1}')
    echo "Tong dung luong: $total_disk"
    echo "Da dung        : $used_disk"
    echo "Con trong      : $free_disk"
    echo "Dung luong thu muc hien tai: $dir_size"
    echo ""
    echo ""
}

# Lay thong tin mang
get_network_info() {
    echo "--- THONG TIN MANG (NETWORK) ---"
    local ip_address=$(hostname -I | awk '{print $1}')
    echo "Dia chi IP: $ip_address"
    echo ""
}

# Goi ham 
# Tao ten file bao cao
REPORT_FILE="report.txt"

# Tao bao cao va ghi vao file
{
    get_time_info
    get_os_info
    get_cpu_info
    get_ram_info
    get_disk_info
    get_network_info
} > "$REPORT_FILE"

echo "Da tao bao cao: $REPORT_FILE"



# TAO FILE HTML


# Lay du lieu de dua vao HTML
current_time=$(date "+%d/%m/%Y - %H:%M:%S")
os_info=$(uname -a)

total_ram=$(free -h --si | awk 'NR==2 {print $2}')
free_ram=$(free -h --si | awk 'NR==2 {print $4}')

cpu_name=$(sudo lshw -class processor 2>/dev/null | grep -m 1 "product:" | awk -F': ' '{print $2}')

disk_total=$(df -h / | awk 'NR==2 {print $2}')
disk_used=$(df -h / | awk 'NR==2 {print $3}')
disk_free=$(df -h / | awk 'NR==2 {print $4}')

dir_size=$(du -sh . 2>/dev/null | awk '{print $1}')

ip_address=$(hostname -I | awk '{print $1}')

# Tao file HTML
HTML_FILE="report.html"

cat <<EOF > "$HTML_FILE"

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <title>Bao Cao He Thong Linux</title>

    <style>

        body{
            font-family: Arial;
            background-color: #f4f4f4;
            padding: 20px;
        }

        h1{
            text-align: center;
            color: #333;
        }

        h2{
            color: #444;
        }

        table{
            width: 100%;
            border-collapse: collapse;
            background: white;
        }

        th, td{
            border: 1px solid #ccc;
            padding: 12px;
            text-align: left;
        }

        th{
            background: #333;
            color: white;
        }

        tr:nth-child(even){
            background: #f9f9f9;
        }

        ul{
            background: white;
            padding: 20px;
            border-radius: 5px;
        }

    </style>

</head>

<body>

    <h1>BAO CAO HE THONG LINUX</h1>

    <h2>Thong Tin Chung</h2>

    <ul>
        <li><b>Thoi gian:</b> $current_time</li>
        <li><b>Dia chi IP:</b> $ip_address</li>
    </ul>

    <h2>Thong Tin Chi Tiet</h2>

    <table>

        <tr>
            <th>Thanh Phan</th>
            <th>Thong Tin</th>
        </tr>

        <tr>
            <td>He dieu hanh</td>
            <td>$os_info</td>
        </tr>

        <tr>
            <td>CPU</td>
            <td>$cpu_name</td>
        </tr>

        <tr>
            <td>Tong RAM</td>
            <td>$total_ram</td>
        </tr>

        <tr>
            <td>RAM Con Trong</td>
            <td>$free_ram</td>
        </tr>

        <tr>
            <td>Disk Tong</td>
            <td>$disk_total</td>
        </tr>

        <tr>
            <td>Disk Da Dung</td>
            <td>$disk_used</td>
        </tr>

        <tr>
            <td>Disk Con Trong</td>
            <td>$disk_free</td>
        </tr>

        <tr>
            <td>Dung luong thu muc hien tai</td>
            <td>$dir_size</td>
        </tr>

    </table>

</body>
</html>

EOF

echo "Da tao giao dien HTML: $HTML_FILE"