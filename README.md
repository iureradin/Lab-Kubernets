Repositorio criado para criar um laboratorio de kubernets

# por enquanto somente o cluster-ubuntu está funcional

- Inicie as vms com o comando: vagrant up
- Vão ser criados 3 vms com ubunto 18
- vagrant ssh cka-node-0
- Execute o comando a seguir: sudo kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"
- Verifique se os pod iniciaram com o comando: kubectl get pods -n kube-system
- Vai ser criado um arquivo ini.txt na home do usuario vagrant que contem o comando para adicionar nós aos clustes, copie e execute nas outras duas vms
- novamente na vm "cka-node-0" verifique a instalação com o comando: kubectl get nodes


