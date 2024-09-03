#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 7073
ENV ASPNETCORE_URLS=https://+:7073

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src

COPY ["eKarton.Subscriber/eKarton.Subscriber.csproj", "eKarton.Subscriber/"]
RUN dotnet restore "eKarton.Subscriber/eKarton.Subscriber.csproj"

COPY . .
WORKDIR "/src/eKarton.Subscriber"
RUN dotnet build "eKarton.Subscriber.csproj" -c Release -o /app/build


FROM build AS publish
RUN dotnet publish "eKarton.Subscriber.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "eKarton.Subscriber.dll"]