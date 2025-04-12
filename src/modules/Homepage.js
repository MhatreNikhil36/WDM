import { Box, Button, Container, Grid, Typography } from "@mui/material";
import { Link } from "react-router-dom";
import Footer from "../components/Footer";

const Homepage = () => {
  return (
    <Box
      sx={{
        minHeight: "100vh",
        width: "100%",
        display: "flex",
        flexDirection: "column", // Changed to column to accommodate footer
        justifyContent: "space-between", // This will push the footer to the bottom
        overflowX: "hidden",
      }}
    >
      <Box
        sx={{
          backgroundColor: "white",
          width: "100%",
          overflow: "hidden",
          display: "flex",
          flexDirection: "column",
          overflowX: "hidden",
          alignItems: "center",
        }}
      >
        {/* 🔹 Hero Section - Fix White Background */}
        <Box
          sx={{
            position: "relative",
            minHeight: "80vh",
            display: "flex",
            alignItems: "center",
            justifyContent: "flex-end",
            backgroundImage: "url('/hero-image.jpg')",
            backgroundSize: "cover",
            backgroundPosition: "center",
            paddingRight: "5%",
            paddingLeft: "5%",
            width: "60%",
          }}
        >
          {/* Text Directly on Image (No Background) */}
          <Box sx={{ maxWidth: "500px", textAlign: "right" }}>
            <Typography variant="h3" fontWeight="bold" color="white">
              REACH YOUR BEST
            </Typography>
            <Typography variant="body1" sx={{ mt: 2 }} color="white">
              Whether you're training for a marathon or your biggest season yet,
              we're here to help you make serious progress.
            </Typography>
            <Button
              variant="contained"
              sx={{
                mt: 3,
                bgcolor: "white",
                color: "black",
                "&:hover": { bgcolor: "#ddd" },
              }}
              component={Link}
              to="/signup"
            >
              SIGN UP
            </Button>
            <Typography variant="body2" sx={{ mt: 2 }} color="white">
              Already a member?{" "}
              <Link
                to="/login"
                style={{ color: "white", textDecoration: "underline" }}
              >
                Log In
              </Link>
            </Typography>
          </Box>
        </Box>

        {/* 🔹 Workout Goals Section */}
        <Container sx={{ py: 10 }}>
          <Grid container spacing={4} alignItems="center">
            {/* Left Side: Text Content */}
            <Grid item xs={12} md={6}>
              <Typography
                variant="h3"
                fontWeight="bold"
                sx={{ textTransform: "uppercase", lineHeight: 1 }}
                color="black"
              >
                Set Goals.
                <br />
                Log Workouts.
                <br />
                Stay on Track.
              </Typography>
              <Typography variant="body1" sx={{ mt: 2 }} color="black">
                Easily track your workouts, set Training Plans, and discover new
                Workout Routines to crush your goals.
              </Typography>
              <Button
                variant="contained"
                sx={{
                  mt: 3,
                  bgcolor: "black",
                  color: "white",
                  "&:hover": { bgcolor: "#333" },
                }}
                component={Link}
                to="/signup"
              >
                GET STARTED
              </Button>
            </Grid>
            {/* Right Side: Image */}
            <Grid item xs={12} md={6}>
              <Box
                component="img"
                src="/workout-image.png"
                alt="Workout Goals"
                sx={{ width: "100%", maxWidth: "500px", borderRadius: 2 }}
              />
            </Grid>
          </Grid>
        </Container>

        {/* 🔹 Performance Analytics Section */}
        <Container sx={{ py: 10 }}>
          <Grid container spacing={4} alignItems="center">
            {/* Left Side: Image */}
            <Grid item xs={12} md={6}>
              <Box
                component="img"
                src="/performance-chart.png"
                alt="Performance Chart"
                sx={{ width: "100%", borderRadius: 2 }}
              />
            </Grid>
            {/* Right Side: Text */}
            <Grid item xs={12} md={6}>
              <Typography variant="h3" fontWeight="bold" color="black">
                BUILT TO MAKE YOU BETTER
              </Typography>
              <Typography variant="body1" sx={{ mt: 2 }} color="black">
                Turn your phone or smartwatch into your coach—track your
                workouts and get tons of data and tips to help you run better.
              </Typography>
              <Typography
                variant="h6"
                fontWeight="bold"
                sx={{ mt: 3 }}
                color="black"
              >
                Custom Workouts
              </Typography>
              <Typography variant="body1" color="black">
                5K? Marathon? No matter where you're at, get personalized
                training plans built just for you.
              </Typography>
            </Grid>
          </Grid>
        </Container>
      </Box>
      <Footer />
    </Box>
  );
};

export default Homepage;
