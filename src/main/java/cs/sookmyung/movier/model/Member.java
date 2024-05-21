package cs.sookmyung.movier.model;

public class Member {
    private String nickname;
    private String socialPlatformId;
    private String profileImg;

    public Member(String nickname, String socialPlatformId, String profileImg) {
        this.nickname = nickname;
        this.socialPlatformId = socialPlatformId;
        this.profileImg = profileImg;
    }

    public String getNickname() {
        return nickname;
    }

    public String getSocialPlatformId() {
        return socialPlatformId;
    }

    public String getProfileImg() {
        return profileImg;
    }
}