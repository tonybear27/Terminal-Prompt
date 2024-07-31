#!/bin/zsh

current_time=$(date +%H%M)

# Change here
Name="Tony🐽"

morning=("J'espère que vous passerez une matinée fantastique et une journée encore meilleure😌" "J'espère que vous avez passé une merveilleuse nuit de sommeil et que vous avez fait de beaux rêves😙" "Saisir le jour. Ou éternuer la journée😛. Quoi qu’il en soit, soyez bénis !" "Humeur géniale. Oups, il est trop tôt pour ça.🤪" "Tu veux venir et répéter avec moi 10 fois de plus ?🤣")

afternoon=("Comment se passe ta journée?👻" "Une bonne nuit vous attend ! Restez béni cet après-midi.😊" "Profitez de chaque instant car ces journées passent trop vite ! Puissiez-vous passer un après-midi mémorable!😆" "Comme votre matinée a été rafraîchissante, que votre après-midi soit amusant et je souhaite que votre nuit soit également relaxante.😉" "Ne perdez jamais espoir – Bon après-midi.😃")

evening=("Aujourd'hui c'est un grand jour, oui ?🥹" "Juste un rappel amical que c'est le moment idéal pour savourer une bonne tasse d'humour et une pincée de rire.🤭" "N'oubliez pas que le meilleur moment pour être productif n'est... pas maintenant. C'est l'heure de rire !😂" "Si vous cherchez un panneau pour prendre une collation et en profiter, c'est celui-là. Vous êtes les bienvenus!🙃")

night=("Il est temps de se détendre et de se relaxer~🛌" "Ne laissez pas les punaises de lit... en fait, vous savez quoi, laissez-les simplement s'en occuper. Cela fait trop longtemps qu'ils se relâchent !🥱" "Je vous souhaite une bonne nuit de sommeil, où vous pourrez enfin rattraper toutes ces émissions que votre patron pense que vous avez déjà regardées.😲" "N'oubliez pas que celui qui se lève tôt peut attraper le ver, mais l'oiseau de nuit obtient la pizza entière.🍕" "Il est temps de se dire bonne nuit et de faire de beaux rêves, mais pas le genre de rêves où l'on tombe d'une falaise. Visons ceux avec du chocolat à volonté.🤤")

if [[ $current_time -ge 0600 && $current_time -lt 1200 ]]; then
    num_messages=${#morning[@]}
    random_index=$((RANDOM % num_messages))
    echo "🇫🇷  🌞 Bonjour ${Name}! ${morning[random_index]}"
elif [[ $current_time -ge 1200 && $current_time -lt 1700 ]]; then
    num_messages=${#afternoon[@]}
    random_index=$((RANDOM % num_messages))
    echo "🇫🇷  💫 Bonjour ${Name}! ${afternoon[random_index]}"
elif [[ $current_time -ge 1700 && $current_time -lt 2300 ]]; then
    num_messages=${#evening[@]}
    random_index=$((RANDOM % num_messages))
    echo "🇫🇷  😇 Bonsoir ${Name}! ${evening[random_index]}"
else 
    num_messages=${#night[@]}
    random_index=$((RANDOM % num_messages))
    echo "🇫🇷  😴 Bonne nuit ${Name}! ${night[random_index]}"
fi

## battery
# Function to get the battery status
function battery_status() {
    local battery_info
    battery_info=$(pmset -g batt | grep -E -o '\d+%')

    local battery_percentage
    battery_percentage=$(echo "$battery_info" | sed 's/%//')

    battery_info="${battery_info}%"
    local color

        if [[ $battery_percentage -ge 51 ]]; then
            color='green'
        elif [[ $battery_percentage -ge 21 ]]; then
            color='yellow'
        else
            color='red'
        fi
    echo "⚡️%F{$color}$battery_info"
}

# Function to update RPROMPT with battery status
function update_battery_status() {
    RPROMPT="%* $(battery_status)"
}

# Initial setup
update_battery_status

# Function to run before each command
function precmd() {
    update_battery_status
}

PROMPT="%B%F{cyan}${Name}%f%b %F{10}%D%f%F{10} ~/%1~%B: ~ %% %F{white}%f%b"

# Define a function to be executed when the terminal is closed
function on_exit() {
    echo "Au Revoir, ${Name}! 👋🏻 🥰"
}

# Trap the EXIT signal to call the on_exit function
trap 'on_exit' EXIT
