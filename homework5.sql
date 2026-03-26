CREATE TABLE "users"(
    "id" serial NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "email" VARCHAR(255) NOT NULL,
    "password" VARCHAR(255) NOT NULL,
    "is_admin" SMALLINT NOT NULL,
    "preferences" TEXT NULL,
    "remember_token" VARCHAR(255) NULL,
    "created_at" DATE NOT NULL,
    "updated_at" DATE NOT NULL
);
ALTER TABLE
    "users" ADD PRIMARY KEY("id");
CREATE TABLE "password_resets"(
    "email" VARCHAR(255) NOT NULL,
    "token" VARCHAR(255) NOT NULL,
    "created_at" DATE NOT NULL
);
CREATE TABLE "settings"(
    "key" VARCHAR(255) NOT NULL,
    "value" TEXT NOT NULL
);
ALTER TABLE
    "settings" ADD PRIMARY KEY("key");
CREATE TABLE "playlists"(
    "id" serial NOT NULL,
    "user_id" INTEGER NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "rules" TEXT NULL,
    "created_at" DATE NOT NULL,
    "updated_at" DATE NOT NULL
);
ALTER TABLE
    "playlists" ADD PRIMARY KEY("id");
CREATE TABLE "playlist_song"(
    "id" serial NOT NULL,
    "playlist_id" INTEGER NOT NULL,
    "song_id" VARCHAR(255) NOT NULL
);
ALTER TABLE
    "playlist_song" ADD PRIMARY KEY("id");
CREATE TABLE "songs"(
    "id" serial NOT NULL,
    "album_id" INTEGER NOT NULL,
    "aritst_id" INTEGER NOT NULL,
    "title" VARCHAR(255) NOT NULL,
    "length" FLOAT(53) NOT NULL,
    "track" INTEGER NULL,
    "disc" INTEGER NOT NULL,
    "lyrics" TEXT NOT NULL,
    "path" TEXT NOT NULL,
    "mtime" INTEGER NOT NULL,
    "created_at" DATE NOT NULL,
    "updated_at" DATE NOT NULL
);
ALTER TABLE
    "songs" ADD PRIMARY KEY("id");
CREATE TABLE "interactions"(
    "id" serial NOT NULL,
    "user_id" INTEGER NOT NULL,
    "song_id" VARCHAR(255) NOT NULL,
    "liked" SMALLINT NOT NULL,
    "play_count" INTEGER NOT NULL,
    "created_at" DATE NOT NULL,
    "updated_at" DATE NOT NULL
);
ALTER TABLE
    "interactions" ADD PRIMARY KEY("id");
CREATE TABLE "artists"(
    "id" serial NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "image" VARCHAR(255) NOT NULL,
    "created_at" DATE NOT NULL,
    "updated_at" DATE NOT NULL
);
ALTER TABLE
    "artists" ADD PRIMARY KEY("id");
CREATE TABLE "albums"(
    "id" serial NOT NULL,
    "artist_id" INTEGER NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "cover" VARCHAR(255) NOT NULL,
    "created_at" DATE NOT NULL,
    "updated_at" DATE NOT NULL
);
ALTER TABLE
    "albums" ADD PRIMARY KEY("id");
ALTER TABLE
    "songs" ADD CONSTRAINT "songs_album_id_foreign" FOREIGN KEY("album_id") REFERENCES "albums"("id");
ALTER TABLE
    "playlists" ADD CONSTRAINT "playlists_user_id_foreign" FOREIGN KEY("user_id") REFERENCES "users"("id");
ALTER TABLE
    "playlist_song" ADD CONSTRAINT "playlist_song_playlist_id_foreign" FOREIGN KEY("playlist_id") REFERENCES "playlists"("id");
ALTER TABLE
    "songs" ADD CONSTRAINT "songs_id_foreign" FOREIGN KEY("id") REFERENCES "playlist_song"("song_id");
ALTER TABLE
    "songs" ADD CONSTRAINT "songs_aritst_id_foreign" FOREIGN KEY("aritst_id") REFERENCES "artists"("id");
ALTER TABLE
    "interactions" ADD CONSTRAINT "interactions_user_id_foreign" FOREIGN KEY("user_id") REFERENCES "users"("id");