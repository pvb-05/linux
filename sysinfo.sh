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
get_time_info
get_os_info
get_cpu_info
get_ram_info
get_disk_info
get_network_info
