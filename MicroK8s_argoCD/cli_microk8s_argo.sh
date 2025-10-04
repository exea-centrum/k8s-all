sudo snap install microk8s --classic
sudo usermod -a -G microk8s $USER
mkdir -p ~/.kube
chmod 0700 ~/.kube
microk8s enable ingress
microk8s enable community
microk8s enable dns
microk8s enable storage
microk8s enable rbac
microk8s enable metrics-server
microk8s enable dashboard
microk8s enable metallb:
microk8s enable argocd
microk8s kubectl config view --raw > ~/.kube/config
sudo chown -R $USER ~/.kube
microk8s kubectl get all -A
microk8s kubectl create token default
token=$(microk8s kubectl -n kube-system get secret | grep default-token | cut -d " " -f1)
microk8s kubectl -n kube-system describe secret $token
microk8s kubectl port-forward -n kube-system service/kubernetes-dashboard 10443:443
https://microk8s.io/docs/addons#heading--list
https://microk8s.io/docs/addon-dashboard


snap list
sudo snap install k9s
sudo ln -s /snap/k9s/current/bin/k9s /snap/bin/k9s
sudo ln -s /snap/k9s/current/bin/k9s /snap/bin/
snap k9s



kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl port-forward svc/argocd-server -n argocd 8080:443
argocd admin initial-password -n argocd
argocd login localhost:8080


https://argo-cd.readthedocs.io/en/stable/getting_started/

alias k=’microk8s kubectl’ lub alias k='sudo microk8s kubectl'
microk8s kubectl create namespace argocd
microk8s kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
microk8s kubectl get po -n argocd
microk8s kubectl get svc -n argocd
microk8s kubectl edit svc argocd-server -o yaml -n argocd




microk8s kubectl get secret -n argocd argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
microk8s kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
Method 1: You can use the one step command:

kubectl get secret -n argocd argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 --decode
Method 2: You can use the below commands:

You can find the default password as suggested in the Kubernetes documentation. First run the below command.

kubectl get secret -n argocd

Then you will find the secret argocd-initial-admin-secret.

Next find the password using the below command.

kubectl get secret -n argocd argocd-initial-admin-secret -o jsonpath='{.data}'

As the output, you'll get something like this. {"password":"UyFCXCpkJHpEc2I9XRMTA=="}%

Finally, you can decode it as below.

echo UyFCXCpkJHpEc2I9XRMTA== | base64 --decode

Put admin as the username & decoded password as the password.

eg: username: admin, password: OxU42WMbomtL

