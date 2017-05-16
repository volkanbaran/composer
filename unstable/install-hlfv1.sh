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
docker pull hyperledger/fabric-ccenv:x86_64-1.0.0-alpha

# Kill and remove any running Docker containers.
docker-compose -p composer kill
docker-compose -p composer down --remove-orphans

# Kill any other Docker containers.
docker ps -aq | xargs docker rm -f

# Start all Docker containers.
docker-compose -p composer up -d

# Wait for the Docker containers to start and initialize.
sleep 10

# Create the channel on peer0.
docker exec peer0 peer channel create -o orderer0:7050 -c mychannel -f /etc/hyperledger/configtx/mychannel.tx

# Join peer0 to the channel.
docker exec peer0 peer channel join -b mychannel.block

# Fetch the channel block on peer1.
docker exec peer1 peer channel fetch -o orderer0:7050 -c mychannel

# Join peer1 to the channel.
docker exec peer1 peer channel join -b mychannel.block

# Open the playground in a web browser.
case "$(uname)" in 
"Darwin") open http://localhost:8080
          ;;
"Linux")  if [ -n "$BROWSER" ] ; then
	       	        $BROWSER http://localhost:8080
	        elif    which xdg-open > /dev/null ; then
	                xdg-open http://localhost:8080
          elif  	which gnome-open > /dev/null ; then
	                gnome-open http://localhost:8080
          #elif other types blah blah
	        else   
    	            echo "Could not detect web browser to use - please launch Composer Playground URL using your chosen browser ie: <browser executable name> http://localhost:8080 or set your BROWSER variable to the browser launcher in your PATH"
	        fi
          ;;
*)        echo "Playground not launched - this OS is currently not supported "
          ;;
esac

# Exit; this is required as the payload immediately follows.
exit 0
PAYLOAD:
� VY �]Ys�Jγ~5/����o�Jմ6 ����)�v6!!~��/ql[7��/�����}�s:�n�O��/�i� h�<^Q�D^���Q��H�@�/�c��F~Nwc����V��N��4{��k��P����~�MC{9=��i��>dF\.�X]ɿ�&���W&����'*���7������r��$�U�/���m��bo��˟@��_~I�s����e"\.�hQɿ\���:�2�L��Oz�Q�A����P�أ���(IS_j�O��#��?����ڽV��Ǭ�]��]�<�l�%l��i��X�$l�s�by����OS$����Q����O�7�gͽ
?G�?��xQ��$�X�����/5��������ؐ՚�}P��	���S�4]h�(�H��&��I����V���l5�M[�Ta&��~ʧ1�<�j���@.6�&h!�S�J�MJO��<�Mt��h�C����@O�{<e��t�����24H���ֶޗ�.��P�Ȗ(z9�����tꬨ
/}��{�S�����h�t�t�s���FU����Wqu|{��уg���QǞ���)x��yQ7dI��y��e�o<�nr���)K�Of}o�9�5��E����p5�Ϻ=M��-�!^�S�b�2�P�t ���0)�����e�C��Nu�NQ����������3� �
`��(��0�ݏ�N4@�U���7��x�깑�S8b	��+��+���B3	�\��{�p_�[��Q��܃���@��w~�N��"r����;i�:�̢n�5�H�X��`a�}� ď�������E�I>�{o-�+����g��x�P����P�ȀS}U���ÛC����F�v#a����+6F�L��~�A�ڀv�,g%�U.܎Pޕ��e��(nugJ7s-j6:p������\��\�"Of�w�f�y4�P?�����scI
&oE�#]��EY�.2&����N�yX12[�FѦI����(�7͕��d(D�$�8�e�G �C'r����"�.a�E��,��~����a�];�Cn9I[RMM/f]}�d	�,�9�x�,z�4����������Wf9�%��M�7��{��+�/$�G�Om�W�}��J������_���Dw��5��0o�w�~�K�[�{�<�CKn�c�0C��q"T�G�z	�B?bԷ*�!)Gv�A,�
�
�]����̽/S$y�@�� � �Pt%�ĳ	#�y"X�]2�ؽ-&�n�8�5�5�!���ĉ�����]=t���[���^�湘[��A+\�����{�Х��Soz�.��Ti�\OT�Z�@a����h�i��iʙ������E�r>� ����Mf��rB�=<�!�|-�t��������L^��B>J$��O'��� ׁ��C�(��3�f&$���	I4��������5�/����&�f,O`@�Ϲ)��3��%��j���Ur(q��C�����%���o`���?IRU�G)������������2P����_���=����1���?��x��e������?��W
���*����?�St��(Fxe���	p�d��CД�4�2��:F������8�^��w������(��*�*��\�÷{�`?�hR��Ñ�z���:�%���# �����2�^��Y��l�V0#&㆜4M��2��[��a=���j�K�9��n��vdA{0���m-��v���
��%H��,e{V�?��/��ό����K�G�����J���j����������w��ό����|���H�O�������L���7s(<:��P�қ�]���O�������:vK}�������`p�{;h2�} ��U�>2�2<�$�zo*ͭ��3A>���w���]����t�x�͆�f2o�z�D���D!P����]�p�r'�v�ó@�D�s�m�ȸ��IG�^p ?G��qڠy����8�9@z��%�i�V��ڹN�M�}��6Y��.,����μ����´gO&M��@�$0A����^��Y��h1	�x�� ��i��=SZ������SMG��v"FR>�9K����Ё��yW 'Y1�������)~I�b�IW�_>D���S�)��������?�x��w�w� ���ѢA��e���B�/�b������T�_���.���(��@Т�����%��16���ӏ:��O8C������빁[�8�(���H��>��,IRv�����_���$Q�e���?�	�"�Z�T��csbkL�6��s�U�����Г��b�J }'��N�VRjhH�(�Nb{��W#�D�Q�[��nno��P�' �!H�g�A+z�d�~8�����fU�߻�x�ǩ���b���j���A��ߙ��?T���\(��ח)���t��K�{���������r��8NU�/)����^,Ő��o)��0}~���������F���g1"`1Ǳm�el��P��%X�=,�h��]�� g	&�f�G����P��/����c��j���q��O���>H-�j7���X&��\=V�k��������Հ&\xٮ��sX]W|.E�T�;��ͣ�L8�u>ʼf$���-�?����!�V�g"�	���� ����֫��w�#��K�A�a�T�������CI��G�����||��P}i�P�2Q��_��P�|�M X�������1�������]���X��a������G��п�����q����r1��Zo�H_�����A�9t�z��K��<�Ѓ��v��3q�p�i��N�c1/��]h����Cb�ڷ�M�	l#ע�iV��X�g�����z�N��7o�(6W3����V\4�ߛ��
�[g���|�G�-ãe�q>#=<$l��v:$�\h���@8ǻ5u���(J�&���t�*�)�sj�N%��ǆĭ�0����@ u�3"�mo�ey��·A�Ě@�D0�ljN�����|sO���F���4�r�Yf<%���?m{�ȡ��<wJl���'�M�V������Z���"k�JC�y�`��_:���+����?�W��߄�Y�?��܀�e��U����O�����m�?���?�m�a��o��N2;M�p�g�?�?�qo(�g���@y�@wA�zd������5`�uM|����䃀$�H���PwSR������ؚ���ms�ѷl���D��!�5S9v-Mhҩl�$��ԺN�t-�\9N�j�x-�4!���A��}�R{���Ț���	�H�6k��y�^wӾ�R󬑬�R��S2���k�g�`�r����߃�N�Ѱ	#$�{Da�6������H��R:��������R�[�������OI���_m��sP��߳�������|T������_���Q��+���?�a��?�����uw1�cBW񟥠����+��s���������?�ￕ��������c�v�q(�%\���"��� p���G	�X�
p�G(�����*�o�2�������/$]������ �eJ���-sjư���S�m�m+[,�Fi�5y���1��t�V�֕�FwGѽdMq=�o{;�cF��sh}�
��A~
ӻ�N���r���)�2�Q_��,6��yu���bw�����8�����������i��� ��_�~�Z�k�/�/��t;u��+T��6r��j������>�Ӆ��rl'��W��u�P7q�^#�ȕ�H&��3�r;M�e�/���jW5	p������U�o��v�����?=}0��u������z��_��b�F���Z�&�+����{Ԏ�]׮����nE0]��W��$����������|@�ڕS;��z�7���]y�!�ƋM�?�k���n_��-n�{���K?�Y�Q1+\���fP���V��9O�վ2�n�]4��� �~�UQ����7D�.��ߐ�ӟ[�}���F�+|;��������>�z��8N�����\;�BϾ��.:J�'ߺ�o^m-���DYrg��x�ӿ)Ɔ��w���_���I"}�����<<��>�����S��ݭ���M�v����緲�W￟��c��?m�\�{�����q:�.�o�~��q���8��8K]8��'�PY?Xn��v��>ф�D����8���K�n�>j������gd���0�X=��^��6)���7|�*��q$�C4dE��o��y�VGƷu���J�f�^WV�o��t���I��᭝��f	�-����B?}�'����]m��d���rx.\%�� �1����뺗�u�麭{ߔ\{���֭=�މ	jBL0�%h�$h�����~R�4��H���#
1Q?�m��lg�9;����M�����ҧ��������<�i����%��d:c�lr�rSn%d"v���D2A�")<]F;�Y#�L&���LG�a\��e혀��I��,/L��p:�ǭ��7�r`��ѱ��b 6t/��5 h��s�3�ۄ�J�ńq!v�E�Q�%I������v��k�&��u#��
�k�Cn��4�0�Rt�kq���3V3EL<�d�v[�t�ԵQ�w����|x�Y����P�����&3ّ鶐-$��[�'�%��*|��H�w�w�8g܄�e���_3�\We�ДF�#!2�R��8�.�F�j�5�w���Bi1^2f^�[��[7gyQc4E��)��F�E�E�e�6��Q�ti&Nm8=�����_�S�;��ɉ����4�b|�\]������iU��=�s�g�w�yN��S�9�uPK�!ˠ�Hҩ��#U��q���YG�S���=�Re�EXs�7#�ˈ�H���׌�����|t�D��8��U���.s�fGW���u�q�]d��SyV��R�6y����U�.r�\�lQ�I�Z;[3o u��j����g��d&/G��O�����g�uT�h��*�7V�x�s.���=��k�n���4m&?�t눅��8/��f��8��ˈ	���91�{�*���v.����7��Z��|WW�%�Ѕ����÷9Z���������3w��T��WU�1�p�i�捣�����#`>��&�m�߭:����F��f��������w?�W��!PX;�qj��?���Z*q�m����<�j �S��ȶ�W�~ԍm{Y�^϶�Zu�� Ώp��r���������g~��c�V3�=��o�_~�k����W(�v+�x��~�׌�����w��^�s�G��U��3�o���87s��' 59cS��xS��~qS�#0��)n^�gq�������"���\���zt��K�x�s��:^��'���Z�����o����.�6�����۰;�(���`� G�~�t�9!"om��Wh3�B��^����\?_%w����|q�G�L=_N�s��[��K����6'�Ka�ȳ�Nw���)%�
G{����4�����b=�DY|"�H��[�(�2�젯d����"R��ճ�%���(W���������\
Jj��жJ�*S,����RS
��z���`���z��̈́���6v&,���2��a�S�z�km�	����-5C��֞�+!�V5���֢隒��� ��U�O2Ii�M��\=.�}-�x��&��\�D�����	�w$�3a2�p��	�CYIf�a�H�����P;�a���O�sȺGxFv�`Y�Nd&h?�U�C��Z-+�]����O�"M�i^�Ɓ�a�4W�4��g���f"X���!�h�����Ϗ1�}��|��%|Lʲd�e�rg6s�)��Rܷé���;���4�
H��#Т��Z�p>�!��,��WB�0VL��&,�)��VZ��++�*hnS�S���V��.����i����LKJ�)��٥�U=x�W�iߐ$�.�[V�4�]�HT�z��&-∩,�a����D��B�*����H�ɔ�B5���b��*.���[�,����_Y�+(K��x�B�
�GI��g�����&���j��v��~%��-�0԰�ƕhQ��ɵ�J�����#1��&��pNY�b�&�܋������r�3e�A�e����ReaB��w��������PR���t��5�r�l�M�}� �o6$u�G$�ZS�ڄ��y
u�P�d�"[� ��ۓ,v�~��}6�g�}��|��S��Ӝ(����ڼ�A�έ]	m@k�)�+6�@�M�J[�<`|]����Sy֡3�y֯��*ͳ�CU�q�.ȶ9��˝6t#t���u55K�np�Py�sPJ�j� �	�܀s��qI�ܸ�D�b
i^k�5��MUu=���[ZG�Z�N���,ɖ�\k�&S�����5�����!g~�aݦ�ꜳЙ�� 0��~� n�<+�*fˡ[��u�k��1U��m���Ĵ��).+z�<8�+���
�9��3�=m �@�e��x�AN�, �j3����r���ou�#7�"/o�Co�C[�-�~)�_
V~)x���{��`�Zx�n��R�T�X!H�pw˳��[xP8��-u$D�RGc��pv4h��F��5�=E�ꂃ�=Np�'���1ݬ)����A�=`� |"���w�Ԧ��I��a#
a�@e�HqKK4�C�G�!$��z/@r^!�E���SʣyݹM��ƕ|��0X�q��ʡ�=8T�x
��{>�G�B�8��Ocb<$��Cv���5I�� �Q�7��w����J1���H��0�K����>�H������RPQ�ٰi�.Ε��5�0������>Ջ	���n���T׺��) �ԡ���L�jZ������ᴍ�6�8�c]�^���m�Sy˔sy���Ǝ�t��ϴb������o��p=t�ʰ��N<,���{���'���?����r_ˎ�}p"i�"����(�+I���U.�D똗`s
d���Gv�T,E�:΃Ճ"�LPdG�LZFA��fMYVz<�-\��C��$01������H2�#b;�qj�@����A�`J�G�.
@��tI��(����rw��(�.�$��	�ha:�7ٍ���v�n�ÄH�-5�vԳ����<9$�J�m�>�|ig p�X������WJU�$/�a�g�B��Q?��]ْ��wxX[�\ �dI^+�K�H��M�Z�D
�.����e�m�o�q(��=�[�)s�)�ɱB�k���
a����V3lb�l���ZKȴ���f�p�?z�aJ|}��+��4^�{�p���?�ǅ� � 6!Z�2Q���w@p�^�{.�j4I'����{X̮W��[���4B�����z��w}饿<��ǡk��@X��v�k���f���\ǁ�OԻw����^���g���O��/�q�ǿ�t���7=�͛���_M����������8�N���kWx��+�+z��k��D�
��}#��+?��g����t�g�����_�Ƈ��^��k�G
����'��,��U��iS;mj�M�i6�����~��k�퀴M����6����l���@�<4��2�A/�T�
��F�a��`��ݶ�:�x��c��31t������?qzm���"d�l���؟R�O�6��6�8�3��8�G`\2��|�65�f��eϙ�����{Z�=-��3c�m�a����a
�嘙s��p���J�|wɣ�H�<.~��Ak���?;��Nv���6���q/  