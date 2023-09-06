FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env
WORKDIR /app

# Salin file csproj dan restore
COPY *.csproj ./
RUN dotnet restore

# Salin seluruh aplikasi dan build
COPY . ./
RUN dotnet publish -c Release -o out

# Tahap runtime
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY --from=build-env /app/out .

ENTRYPOINT ["dotnet", "FirstWebApps.dll"]