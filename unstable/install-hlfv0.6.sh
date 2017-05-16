(cat > composer.sh; chmod +x composer.sh; exec bash composer.sh)
#!/bin/bash
set -ev

# Get the current directory.
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Get the full path to this script.
SOURCE="${DIR}/composer.sh"

# Create a work directory for extracting files into.
WORKDIR="$(pwd)/composer-data"
rm -rf "${WORKDIR}" && mkdir -p "${WORKDIR}"
cd "${WORKDIR}"

# Find the PAYLOAD: marker in this script.
PAYLOAD_LINE=$(grep -a -n '^PAYLOAD:$' "${SOURCE}" | cut -d ':' -f 1)
echo PAYLOAD_LINE=${PAYLOAD_LINE}

# Find and extract the payload in this script.
PAYLOAD_START=$((PAYLOAD_LINE + 1))
echo PAYLOAD_START=${PAYLOAD_START}
tail -n +${PAYLOAD_START} "${SOURCE}" | tar -xzf -

# Pull the latest Docker images from Docker Hub.
docker-compose pull
docker pull hyperledger/fabric-baseimage:x86_64-0.1.0
docker tag hyperledger/fabric-baseimage:x86_64-0.1.0 hyperledger/fabric-baseimage:latest

# Kill and remove any running Docker containers.
docker-compose -p composer kill
docker-compose -p composer down --remove-orphans

# Kill any other Docker containers.
docker ps -aq | xargs docker rm -f

# Start all Docker containers.
docker-compose -p composer up -d

# Wait for the Docker containers to start and initialize.
sleep 10

# Open the playground in a web browser.
case "$(uname)" in 
"Darwin")   open http://localhost:8080
            ;;
"Linux")    if [ -n "$BROWSER" ] ; then
	       	        $BROWSER http://localhost:8080
	        elif    which xdg-open > /dev/null ; then
	                 xdg-open http://localhost:8080
	        elif  	which gnome-open > /dev/null ; then
	                gnome-open http://localhost:8080
                       #elif other types bla bla
	        else   
		            echo "Could not detect web browser to use - please launch Composer Playground URL using your chosen browser ie: <browser executable name> http://localhost:8080 or set your BROWSER variable to the browser launcher in your PATH"
	        fi
            ;;
*)          echo "Playground not launched - this OS is currently not supported "
            ;;
esac

# Exit; this is required as the payload immediately follows.
exit 0
PAYLOAD:
� VY �[o�0�yxᥐ� �21�BJ�AI`�S<r�si���>;e����R�i����s|αq{q��0�`k繵w�'�zz��|�NE��	�@4�v�k���^��J�$�-@-�V������))�
|	������0�. �">��� �Yk(��.�؅�b��Zad7sʧ���4�V�%4CS��a���e" ��q�w;�42�S�߃~|M�鍬��rh�����F�G�'0����,ߑr�{��B��-O���@mB�֦�v�&R����UM6粬���H�u}�0ԑl�C�փp9%������'>z�8�K-����l;�"r+R��x2������H�Y�+>?�I�*��S&�� ������o�+������B���~��h���u�0����Nt�U�����>�t�[��L�"�k�B��0ڀ��a��2����_: �ă�٪�'������g������n���w*[����%ziT-0����V4�P��U�Tq��n'c	|�; �qx�n��7s< Fu�� ����CK��-�Qsy�p`dc�OP��11�6R����b"��\vn�ni�z�L�m�̵�1tHV��F�I�YܠP��M�ӭqh�|���	h/��c�@e-LIwɪR/V�-t����R,�|I��4�� yν=_�K̛
n9�
�5���n����w��zq|������`0��`0��`0��`�M~�� (  