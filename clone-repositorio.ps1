## SCRIPT PARA CLONE DO GITLAB USANDO - Personal Access Token

# Verifica se o token existe no path $HOME do usuário
  # se não existir, pede o token do usuário e salvar no $HOME\token_gitlab.txt
# Se existir pedir a url do repositório
# Clonar o repositorio com o token do usuário

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$PSDefaultParameterValues['Out-File:Encoding'] = 'utf8'
$PSDefaultParameterValues['Get-Content:Encoding'] = 'utf8'

$hasTokenLocal = Test-Path -Path $HOME\token_gitlab.txt -PathType Leaf

if($hasTokenLocal -eq $false) {
  Write-Warning "Token não encontrado, pedindo token..."
  Read-Host "Digite o token do GitLab" > $HOME\token_gitlab.txt
  $tokenLocal = (Get-Content -Path $HOME\token_gitlab.txt -Encoding utf8).Trim()
}

$tokenLocal = (Get-Content -Path $HOME\token_gitlab.txt -Encoding utf8).Trim()

if($tokenLocal -eq $false) {
  Write-Error "Token não encontrado ou inválido, tente novamente..."
  exit 0
}

Write-Host "token encontrado: $tokenLocal" -ForegroundColor Green 


$urlRepository = (Read-Host "Digite o repositorio do GitLab").Trim()

if([string]::IsNullOrEmpty($urlRepository)) {
  Write-Warning "Repositorio não encontrado, tente novamente..."
  exit 0
}

$newUrlRepository = $urlRepository.Replace('gitlab.corebiz', "oauth2:$($tokenLocal)@gitlab.corebiz")
Write-Host "git clone $newUrlRepository"
Start-Sleep -s 4
# Set-Clipboard -Value "git clone $newUrlRepository"
git clone $newUrlRepository